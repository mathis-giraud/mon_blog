#' divide_triangle
#'
#' Triangle de Sierpiński
#'
#' @param xa Coordonnées en abscisses de A
#' @param ya Coordonnées en ordonnées de A
#' @param xb Coordonnées en abscisses de B
#' @param yb Coordonnées en ordonnées de B
#' @param xc Coordonnées en abscisses de C
#' @param yc Coordonnées en ordonnées de C
#' @return Retourne 3 triangles à partir d'un triangle initial
#' @examples
#' divide_triangle(0,0,1,1,2,0)
#' divide_triangle(0,0,0,1,2,1)
divide_triangle <- function(xa, ya, xb, yb, xc, yc) {
  # Calcul des points intermédiaires pour les triangles
  xm_ab <- (xa + xb) / 2
  ym_ab <- (ya + yb) / 2
  xm_bc <- (xb + xc) / 2
  ym_bc <- (yb + yc) / 2
  xm_ca <- (xc + xa) / 2
  ym_ca <- (yc + ya) / 2
  triangle1 <- list(xa, ya, xm_ab, ym_ab, xm_ca, ym_ca)
  triangle2 <- list(xm_ab, ym_ab, xb, yb, xm_bc, ym_bc)
  triangle3 <- list(xm_ca, ym_ca, xm_bc, ym_bc, xc, yc)
  # Retourne la liste de triangles
  return(list(triangle1, triangle2, triangle3))
}


#' divide_list_triangle
#'
#' Triangle de Sierpiński
#'
#' @param liste_triangle Une liste de triangles
#' @return Retourne une liste de triangles
divide_list_triangle <- function(liste_triangle) {
  new_liste_triangle <- list()
  for (i in (1:length(liste_triangle))) {
    new_liste_triangle <- append(new_liste_triangle,
                                 divide_triangle(liste_triangle[[i]][[1]],
                                                 liste_triangle[[i]][[2]],
                                                 liste_triangle[[i]][[3]],
                                                 liste_triangle[[i]][[4]],
                                                 liste_triangle[[i]][[5]],
                                                 liste_triangle[[i]][[6]]))
  }
  return(new_liste_triangle)
}

#' plot_triangles
#'
#' Triangle de Sierpiński
#'
#' @param liste_triangle Une liste de triangles
#' @return Retourne un graphique des triangles de Sierpiński
plot_triangles <- function(liste_triangle) {
  new_list <- unlist(liste_triangle)
  mini <- min(new_list)
  maxi <- max(new_list)
  plot(0, 0, xlim = c(mini, maxi), ylim = c(mini, maxi), type = "n")
  for (i in (1:length(liste_triangle))) {
    polygon(c(liste_triangle[[i]][[1]],
              liste_triangle[[i]][[3]],
              liste_triangle[[i]][[5]]),
            c(liste_triangle[[i]][[2]],
              liste_triangle[[i]][[4]],
              liste_triangle[[i]][[6]]), col = "black")
  }
}


#' calcul_longueur_cote_triangle
#'
#' @param liste_triangle Une liste de triangles
#' @return Retourne un graphique des triangles de Sierpiński
calcul_longueur_cote_triangle <- function(liste_triangle) {
  aire_triangle <- 0
  for (i in (1:length(liste_triangle))) {
    a <- distance(liste_triangle[[i]][[1]],
                  liste_triangle[[i]][[2]],
                  liste_triangle[[i]][[3]],
                  liste_triangle[[i]][[4]])
    b <- distance(liste_triangle[[i]][[3]],
                  liste_triangle[[i]][[4]],
                  liste_triangle[[i]][[5]],
                  liste_triangle[[i]][[6]])
    c <- distance(liste_triangle[[i]][[1]],
                  liste_triangle[[i]][[2]],
                  liste_triangle[[i]][[5]],
                  liste_triangle[[i]][[6]])
    aire_triangle <- aire_triangle + heron(a, b, c)
  }
  return(aire_triangle)
}


distance <- function(x1, x2, y1, y2) {
  sqrt((x2 - x1)^2 + (y2 - y1) ^ 2)
}

heron <- function(a, b, c) {
  if (is.numeric(a) & is.numeric(b) & is.numeric(c)) {
    if (a <= 0 | b <= 0 | c <= 0) {
      warning("Attention, un des éléments est inférieur ou égal à 0")
    }else {
      p <- demi_perimetre(a, b, c)
      aire <- sqrt((p * (p - a)) * (p - b) * (p - c))
      if (is.nan(aire))
        warning("Ce triangle n'existe pas")
      else
        return(aire)
    }
  }else {
    stop("Attention, un des arguments n'est pas numérique")
  }
}

demi_perimetre <- function(a, b, c) {
  p <- (a + b + c) / 2
  return(p)
}
