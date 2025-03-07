#' Gradient colour scales
#'
#' `scale_*_gradient` creates a two colour gradient (low-high),
#' `scale_*_gradient2` creates a diverging colour gradient (low-mid-high),
#' `scale_*_gradientn` creates a n-colour gradient. For binned variants of
#' these scales, see the [color steps][scale_colour_steps] scales.
#'
#' Default colours are generated with \pkg{munsell} and
#' `mnsl(c("2.5PB 2/4", "2.5PB 7/10"))`. Generally, for continuous
#' colour scales you want to keep hue constant, but vary chroma and
#' luminance. The \pkg{munsell} package makes this easy to do using the
#' Munsell colour system.
#'
#' @inheritParams scales::seq_gradient_pal
#' @inheritParams scale_colour_hue
#' @param low,high Colours for low and high ends of the gradient.
#' @param guide Type of legend. Use `"colourbar"` for continuous
#'   colour bar, or `"legend"` for discrete colour legend.
#' @inheritDotParams continuous_scale -na.value -guide -aesthetics
#' @seealso [scales::seq_gradient_pal()] for details on underlying
#'   palette, [scale_colour_steps()] for binned variants of these scales.
#' @family colour scales
#' @rdname scale_gradient
#' @export
#' @examples
#' set.seed(1)
#' df <- data.frame(
#'   x = runif(100),
#'   y = runif(100),
#'   z1 = rnorm(100),
#'   z2 = abs(rnorm(100))
#' )
#'
#' df_na <- data.frame(
#'   value = seq(1, 20),
#'   x = runif(20),
#'   y = runif(20),
#'   z1 = c(rep(NA, 10), rnorm(10))
#' )
#'
#' # Default colour scale colours from light blue to dark blue
#' ggplot(df, aes(x, y)) +
#'   geom_point(aes(colour = z2))
#'
#' # For diverging colour scales use gradient2
#' ggplot(df, aes(x, y)) +
#'   geom_point(aes(colour = z1)) +
#'   scale_colour_gradient2()
#'
#' # Use your own colour scale with gradientn
#' ggplot(df, aes(x, y)) +
#'   geom_point(aes(colour = z1)) +
#'   scale_colour_gradientn(colours = terrain.colors(10))
#'
#' # Equivalent fill scales do the same job for the fill aesthetic
#' ggplot(faithfuld, aes(waiting, eruptions)) +
#'   geom_raster(aes(fill = density)) +
#'   scale_fill_gradientn(colours = terrain.colors(10))
#'
#' # Adjust colour choices with low and high
#' ggplot(df, aes(x, y)) +
#'   geom_point(aes(colour = z2)) +
#'   scale_colour_gradient(low = "white", high = "black")
#' # Avoid red-green colour contrasts because ~10% of men have difficulty
#' # seeing them
#'
#'# Use `na.value = NA` to hide missing values but keep the original axis range
#' ggplot(df_na, aes(x = value, y)) +
#'   geom_bar(aes(fill = z1), stat = "identity") +
#'   scale_fill_gradient(low = "yellow", high = "red", na.value = NA)
#'
#'  ggplot(df_na, aes(x, y)) +
#'    geom_point(aes(colour = z1)) +
#'    scale_colour_gradient(low = "yellow", high = "red", na.value = NA)
#'
scale_colour_gradient <- function(..., low = "#132B43", high = "#56B1F7", space = "Lab",
                                  na.value = "grey50", guide = "colourbar", aesthetics = "colour") {
  continuous_scale(aesthetics, "gradient", seq_gradient_pal(low, high, space),
    na.value = na.value, guide = guide, ...)
}

#' @rdname scale_gradient
#' @export
scale_fill_gradient <- function(..., low = "#132B43", high = "#56B1F7", space = "Lab",
                                na.value = "grey50", guide = "colourbar", aesthetics = "fill") {
  continuous_scale(aesthetics, "gradient", seq_gradient_pal(low, high, space),
    na.value = na.value, guide = guide, ...)
}

#' @inheritParams scales::div_gradient_pal
#' @param midpoint The midpoint (in data value) of the diverging scale.
#'   Defaults to 0.
#' @rdname scale_gradient
#' @export
scale_colour_gradient2 <- function(..., low = muted("red"), mid = "white", high = muted("blue"),
                                   midpoint = 0, space = "Lab", na.value = "grey50", guide = "colourbar",
                                   aesthetics = "colour") {
  continuous_scale(aesthetics, "gradient2",
    div_gradient_pal(low, mid, high, space), na.value = na.value, guide = guide, ...,
    rescaler = mid_rescaler(mid = midpoint))
}

#' @rdname scale_gradient
#' @export
scale_fill_gradient2 <- function(..., low = muted("red"), mid = "white", high = muted("blue"),
                                 midpoint = 0, space = "Lab", na.value = "grey50", guide = "colourbar",
                                 aesthetics = "fill") {
  continuous_scale(aesthetics, "gradient2",
    div_gradient_pal(low, mid, high, space), na.value = na.value, guide = guide, ...,
    rescaler = mid_rescaler(mid = midpoint))
}

mid_rescaler <- function(mid) {
  function(x, to = c(0, 1), from = range(x, na.rm = TRUE)) {
    rescale_mid(x, to, from, mid)
  }
}

#' @inheritParams scales::gradient_n_pal
#' @param colours,colors Vector of colours to use for n-colour gradient.
#' @rdname scale_gradient
#' @export
scale_colour_gradientn <- function(..., colours, values = NULL, space = "Lab", na.value = "grey50",
                                   guide = "colourbar", aesthetics = "colour", colors) {
  colours <- if (missing(colours)) colors else colours

  continuous_scale(aesthetics, "gradientn",
    gradient_n_pal(colours, values, space), na.value = na.value, guide = guide, ...)
}
#' @rdname scale_gradient
#' @export
scale_fill_gradientn <- function(..., colours, values = NULL, space = "Lab", na.value = "grey50",
                                 guide = "colourbar", aesthetics = "fill", colors) {
  colours <- if (missing(colours)) colors else colours

  continuous_scale(aesthetics, "gradientn",
    gradient_n_pal(colours, values, space), na.value = na.value, guide = guide, ...)
}
