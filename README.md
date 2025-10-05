# week_7_task_Q

**Input**\
`clk`: Basys3 Clock\
`btnL, btnC, btnR, btnU`: Push buttons

**Output**\
`oled_data`: next pixel's colour

**Modules required**
1. `Task_Q_Hongxun`: Top level module
2. `task_Q_controller`: execute task Q's tasks
3. `Custom_Clock`: Generate a custom clock
4. `debouncer`: Debounce button presses
5. `set_square_colour`: Determines colour for a square
6. `draw_stuff`: to draw squares and digit
7. `draw_square`
8. `draw_digit`
9. `Oled_Display`