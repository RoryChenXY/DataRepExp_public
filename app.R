# Launch the ShinyApp (Do not remove this comment)
# To deploy, run: rsconnect::deployApp()
# Or use the blue button on top of this file

# devtools::load_all()

# options("golem.app.prod" = TRUE)

devtools::install_github("RoryChenXY/DataRepExp_public", subdir="datarepexp")

library(datarepexp)

datarepexp::repexp_app() # add parameters here (if any)
