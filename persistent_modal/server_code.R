# server.R

library("ggplot2")

function(input, output, session) {
    
    output$plot <- renderPlot({
        plot()
    })
    
    plot <- reactive({
        input$apply
        
        isolate({
            g <- ggplot(diamonds, aes(x = carat, y = price, col = cut)) + 
                geom_point(alpha = advanced_settings_rv$alpha)
            if (advanced_settings_rv$log_price) {
                g <- g + scale_y_log10()
            }
            g
        })
    })
    
    
    observeEvent(input$advanced_settings, {
        showModal(advancedSettingsModal())
    })
    
    advancedSettingsModal <- reactive({
        modalDialog(
            numericInput('alpha', 'transparency:', min = 0, max = 1, value = alpha_rv()),
            checkboxInput('log_price', "show log of price", value = log_price_rv()),
            footer = tagList(
                modalButton("close"),
                actionButton('apply', 'apply')
            )
        )
    })
    
    
    advanced_settings_rv <- reactiveValues(
        alpha = 0.75,
        log_price = FALSE
    )
    
    alpha_rv <- reactive({advanced_settings_rv$alpha})
    observeEvent(input$alpha, {
        advanced_settings_rv$alpha <- input$alpha
    })
    
    log_price_rv <- reactive({advanced_settings_rv$log_price})
    observeEvent(input$log_price, {
        advanced_settings_rv$log_price <- input$log_price
    })
    
}
