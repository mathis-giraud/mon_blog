library(targets)
library(tarchetypes)
# This is an example _targets.R file. Every
# {targets} pipeline needs one.
# Use tar_script() to create _targets.R and tar_edit()
# to open it again for editing.
# Then,  run tar_make() to run the pipeline
# and tar_read(summary) to view the results.

tar_config_set(store = "my_blog/posts/post-with-code/_targets",
               script = "my_blog/posts/post-with-code/_targets.R")
tar_source("posts/post-with-code/fonctions.R")

# Define custom functions and other global objects.
# This is where you write source(\"R/functions.R\")
# if you keep your functions in external scripts.

# Set target-specific options such as packages.


# End this file with a list of target objects.
a <- c(0,  0)
b <- c(0,  1)
c <- c(0.5,  sqrt(3) / 2)

xa <- 0
ya <- 0
xb <- 0
yb <- 1
xc <- 0.5
yc <- sqrt(3) / 2

list(
  tar_target("triangle_1", divide_triangle(xa, ya, xb, yb, xc,  yc)),
  tar_target(plot_1, plot_triangles(triangle_1)),
  tar_target(distance_1, calcul_longueur_cote_triangle(triangle_1)),
  tar_target("triangle_2", divide_list_triangle(triangle_1)),
  tar_target(plot_2, plot_triangles(triangle_2)),
  tar_target(distance_2, calcul_longueur_cote_triangle(triangle_2)),
  tar_target("triangle_3", divide_list_triangle(triangle_2)),
  tar_target(plot_3, plot_triangles(triangle_3)),
  tar_target(distance_3, calcul_longueur_cote_triangle(triangle_3))
)

tar_make()

targets::tar_script({
  library(tarchetypes)
  list(
    tar_quarto(report,  path = ".")
  )
},  ask = FALSE)
targets::tar_make()
