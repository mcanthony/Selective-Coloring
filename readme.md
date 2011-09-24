# Selective Coloring

![The input Photo](http://dl.dropbox.com/u/59591/crayon.png)

This is a ruby exercise to take an input photo (like the one above) and isolates specific colors.  A sample output might look like this:

![The Red Crayon](http://dl.dropbox.com/u/59591/crayon-red.png)

A specific color is isolated by converting the RGB values to HSL and then selecting targeting all colors that are within a given tolerance.  For example:

  `input.selective_color([79,61,171], 30).save('output-purple.png')`
  
The first argument is the rgb tuple to target, the second argument is the tolerance.