server <- function(input, output, session) {
    ## Reactive values 
    values <- reactiveValues(niveau= NULL, commune= NULL, nom= NULL)  
    ## Initialisation reactive values
    observe({
        if (is.null(values$niveau))  values$niveau  <- input$niveau
        if (is.null(values$commune)) values$commune <- input$commune
        if (is.null(values$nom))     values$nom     <- input$nom
    })
    ## MAJ des reactive values apres un click sur un polygone
    observeEvent(input$mymap_shape_click,{
        values$niveau  <- Pts.Crd$NIVEAU[Pts.Crd$Concat==
                                         input$mymap_shape_click$id]
        values$nom     <- Pts.Crd$NOM[Pts.Crd$Concat==
                                      input$mymap_shape_click$id]
        values$commune <-Pts.Crd$LIBCOM[Pts.Crd$Concat==
                                        input$mymap_shape_click$id]
    })
    ## MAJ des reactive values apres un choix dans menus deroulants
    observeEvent(c(input$commune, input$niveau, input$nom),{
        if (values$niveau  != input$niveau) {
            values$niveau  <- input$niveau
            values$commune <- Pts.Crd$LIBCOM[Pts.Crd$NIVEAU==
                                             values$niveau][ 1]
            values$nom     <- Pts.Crd$NOM[Pts.Crd$LIBCOM==
                                          values$commune][ 1]
        }
        else if (values$commune != input$commune) {
            values$commune <- input$commune
            values$nom <- Pts.Crd$NOM[Pts.Crd$LIBCOM== values$commune][ 1]
        }           
        else if (values$nom!=input$nom){
            values$nom<-input$nom
        }})
    ## MAJ menus deroulants
    observeEvent(c(values$commune, values$niveau, values$nom),{
        updateSelectInput(session, "niveau",
                          choices= c(as.character(
                              unique(Poly.Ras$NIVEAU))),
                          selected=values$niveau)
        updateSelectInput(session, "commune",
                          choices= c(as.character(
                              unique(Poly.Ras$LIBCOM[Poly.Ras$NIVEAU %in%
                                                     values$niveau]))),
                          selected=values$commune)
        updateSelectInput(session, "nom",
                          choices= c(as.character(
                              unique(Poly.Ras$NOM[Poly.Ras$LIBCOM %in%
                                                  values$commune &
                                                  Poly.Ras$NIVEAU %in%
                                                  values$niveau]))),
                          selected=values$nom)
    })
    ## Subset donnees
    getPts <- reactive({
        Pts.Crd[Pts.Crd$NIVEAU %in% values$niveau &
                Pts.Crd$LIBCOM %in% values$commune &
                Pts.Crd$NOM    %in% values$nom, ]})
    ## Carte de base
    output$mymap <- renderLeaflet({
        map@map
    })
    ## Rafraichissement carte
    observe({
        gg <- getPts()
        if (nrow(gg)== 0) return(NULL)
        else {
            bound_box <- as.numeric(st_bbox(Poly.Ras[Poly.Ras$Concat %in%
                                                     gg$Concat,]))
            leafletProxy("mymap") %>%
                clearMarkers() %>%
                fitBounds(lng1= bound_box[ 3], lng2= bound_box[ 1],
                          lat1= bound_box[ 4], lat2= bound_box[ 2]) %>%
                addCircleMarkers(data= (getPts()))}
    })
    ## Violon Plot de base
    output$miplot <- renderPlot({
        yop <- getPts()$SCORE_corrigé
        if (length(yop)==0) return(NULL)
        top <- round(100-
                     aggregate(I(Poly.Ras$SCORE_corrigé< yop)* 100,
                               by= list(Poly.Ras$NIVEAU), mean)[, 2])
        ggplot(Poly.Ras, aes(x= factor(NIVEAU),
                             y= SCORE_corrigé, fill= factor(NIVEAU)))+
            geom_violin(trim= FALSE)+ theme_minimal()+ ylim(40, 100)+
            geom_boxplot(width=0.1, fill= "white")+
            annotate("text", x= 1: 5, y= 100,
                     label= paste("Top", top, "%"), col= "red", size= 7)+
            labs(title= "Comparaison avec les autres parcelles",
                 x= "\n source: jean-sauveur ay @ inra cesaer, voir https://github.com/jsay/geoInd/",
                 y = "Niveau sur une échelle de 1 à 100")+ 
            scale_fill_manual(values= AocPal)+ 
            theme(legend.position= "none",
                  plot.title = element_text(hjust = 0, size = 16),
                  axis.text.x = element_text(size= 14),
                  axis.title.x = element_text(hjust= 0, size= 14),
                  axis.title.y = element_text(size= 14))+
            scale_x_discrete(expand= expand_scale(mult= 0, add= 1),
                             drop= T)+
            geom_hline(yintercept= yop, lty= 2, col= "red")+
            annotate("text", x= 0.35, y= yop+ 2,
                     label= round(yop, 2), col= "red", size= 8)
    }, height = 575, width = 700)
    ## Pour debugguer, ca permet de voir la valeur des input en direct
    output$table <- renderTable({
        data.frame(inp= names(unlist(reactiveValuesToList(values))),
                   val= unlist(reactiveValuesToList(values)))
  })
}
