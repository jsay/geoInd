ui <- dashboardPage(
  dashboardHeader(
    titleWidth= 550, 
    title= "Classification statistique des vignobles de la Côte d'Or"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    fluidRow(
      box(width= 5, height= 670,
          column(width= 4,
                 selectInput(
                   "niveau", label= "Niveau de l'appellation",
                   choices=
                     c(as.character(unique(Poly.Ras$NIVEAU))),
                   selected= 1)),
          column(width= 4,
                 selectInput(
                   "commune", 
                   label= "Commune de la parcelle",
                   choices= c(
                     as.character(unique(Poly.Ras$LIBCOM)),
                     "TOUTES"), selected= 1)),
          column(width= 4,
                 selectInput(
                     "nom",
                     label= "Lieu dit de la parcelle",
                     choices= c(
                         as.character(unique(Poly.Ras$NOM)),
                         "TOUS"), selected = 1)),
          plotOutput("miplot", width='100%')
          ),
      box(width= 7, 
          column(width = 12, 
                 leafletOutput("mymap", height= 645),
                 fluidRow(verbatimTextOutput("mymap_shape_click"))
          )
      )
    )
  )
)
