ui <- dashboardPage(
  dashboardHeader(
    titleWidth= 400, 
    title= "Classification des vignobles de la Côte d'Or"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    fluidRow(
      box(width= 2, height= 375,
          selectInput("niveau", label= "Niveau de l'appellation",
                      choices=
                          c(as.character(unique(Poly.Ras$NIVEAU))),
                      selected= 1),
          selectInput("commune", label= "Commune de la parcelle",
                      choices= c(
                          as.character(unique(Poly.Ras$LIBCOM)),
                          "TOUTES"), selected= 1),
          selectInput("nom", label= "Lieu dit de la parcelle",
                      choices= c(
                          as.character(unique(Poly.Ras$NOM)),
                          "TOUS"), selected = 1)),
      box(width= 3, height= 645, plotOutput("miplot")),
      box(width= 3, 
          column(width = 12, 
                 leafletOutput("mymap", height= 645),
                 fluidRow(verbatimTextOutput("mymap_shape_click"))
          )
      )
    )
  )
)
