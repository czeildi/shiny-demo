fluidPage(
    title = 'persistent modal',
    actionButton('advanced_settings', 'Change advanced settings'),
    plotOutput('plot', height = 600),
    column(6, pre(includeText('ui_code.R'))),
    column(6, pre(includeText('server_code.R')))
)
