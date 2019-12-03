breed [wolves a-wolf]
breed [bison a-bison]
breed [deer a-deer]
breed [moose a-moose]
breed [sheep a-sheep]

turtles-own [ energy ]
patches-own [ grass-density ]

to setup
  clear-all
  ask patches [
    set pcolor green
    set grass-density 10 ;; random-float 10.0
    recolor-grass ;;
  ]
  setup-wolves
  setup-bison
  setup-deer
  setup-moose
  setup-sheep
  reset-ticks
end

to setup-wolves
  create-wolves num-of-wolves
  ask wolves
  [
   set color grey
   setxy random-xcor random-ycor
   set shape "wolf"
   set size 3
   set energy 100
  ]
end

to setup-bison
  create-bison num-of-bison
  ask bison
  [
    set color brown
    setxy random-xcor random-ycor
    set shape "bison"
    set size 2
    set energy 100
  ]
end

to setup-deer
  create-deer num-of-deer
  ask deer
  [
    setxy random-xcor random-ycor
    set shape "deer"
    set size 1
    set energy 100
  ]
end

to setup-moose
  create-moose num-of-moose
  ask moose
  [
    setxy random-xcor random-ycor
    set shape "moose"
    set size 2
    set energy 100
  ]
end

to setup-sheep
  create-sheep num-of-sheep
  ask sheep
  [
    set color white
    setxy random-xcor random-ycor
    set shape "sheep"
    set energy 100
  ]
end

to go
  move-wolves
  move-bison
  move-deer
  move-moose
  move-sheep
  if not any? turtles [ stop ]
  tick
  update-graph
  ask turtles
  [
    should-die
  ]
  regrow-grass
end

to move-wolves
  ask wolves
  [
    wiggle
    forward 0.8
    set energy energy - movement-cost
    ask bison-here [die]
    ask deer-here  [die]
    ask moose-here [die]
    ask sheep-here [die]
  ]
end

to move-bison
  ask bison
  [
    eat-grass
    wiggle
    forward 0.3
    set energy energy - movement-cost
  ]
end

to move-deer
  ask deer
  [
    eat-grass
    wiggle
    forward 0.9
    set energy energy - movement-cost
  ]
end

to move-moose
  ask moose
  [
    eat-grass
    wiggle
    forward 0.5
    set energy energy - movement-cost
  ]
end

to move-sheep
  ask sheep
  [
    eat-grass
    wiggle
    forward 0.5
    set energy energy - movement-cost
  ]
end

to update-graph
  set-current-plot-pen "wolves"
  plot count wolves

  set-current-plot-pen "bison"
  plot count bison

  set-current-plot-pen "deer"
  plot count deer

  set-current-plot-pen "moose"
  plot count moose

  set-current-plot-pen "sheep"
  plot count sheep
end


to wiggle
  right 45 - (random 90)
end

to should-die
  if energy < 0
  [
    die
  ]
end

;;PREDITOR PRAY DECLORATIONS


;;GRASS GENERATION CODE

to recolor-grass
  ;;  set pcolor scale-color green grass 0 20
  set pcolor scale-color green (10 - grass-density) -10 20
end

;; regrow the grass
to regrow-grass
  ask patches [
    set grass-density grass-density + grass-growth-rate
    if grass-density > 10.0 [
      set grass-density 10.0
    ]
    recolor-grass
  ]
end

to eat-grass
  ;; check to make sure there is grass here
  if ( grass-density >= nrg-gain-from-grass ) [
    ;; increment the sheep's energy
    set energy energy + nrg-gain-from-grass
    ;; decrement the grass
    set grass-density grass-density - nrg-gain-from-grass
    recolor-grass
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
647
448
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
1
1
1
ticks
30.0

BUTTON
24
20
87
53
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
114
21
177
54
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
18
78
190
111
num-of-wolves
num-of-wolves
0
100
0.0
1
1
NIL
HORIZONTAL

SLIDER
19
132
191
165
num-of-sheep
num-of-sheep
0
100
10.0
1
1
NIL
HORIZONTAL

SLIDER
19
185
191
218
num-of-bison
num-of-bison
0
100
8.0
1
1
NIL
HORIZONTAL

SLIDER
21
234
193
267
num-of-deer
num-of-deer
0
100
13.0
1
1
NIL
HORIZONTAL

SLIDER
21
287
193
320
num-of-moose
num-of-moose
0
100
8.0
1
1
NIL
HORIZONTAL

PLOT
5
336
205
486
Population over Time
Time
Population
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"wolves" 1.0 0 -7500403 true "" ""
"bison" 1.0 0 -6459832 true "" ""
"deer" 1.0 0 -955883 true "" ""
"moose" 1.0 0 -987046 true "" ""
"sheep" 1.0 0 -534828 true "" ""

SLIDER
665
73
837
106
movement-cost
movement-cost
0
100
1.0
1
1
NIL
HORIZONTAL

SLIDER
797
205
969
238
grass-growth-rate
grass-growth-rate
0
2.0
0.1
0.1
1
NIL
HORIZONTAL

SLIDER
660
272
832
305
nrg-gain-from-grass
nrg-gain-from-grass
0
2.0
2.0
0.1
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

bison
false
9
Circle -6459832 true false 203 65 88
Circle -6459832 true false 35 30 202
Circle -6459832 true false 150 60 150
Polygon -16777216 true false 248 165 270 210 285 210 308 165
Circle -16777216 true false 244 117 67
Rectangle -16777216 true false 164 223 179 298
Polygon -16777216 true false 45 285 30 285 30 240 15 195 45 210
Circle -6459832 true false -5 105 136
Rectangle -16777216 true false 65 221 80 296
Polygon -16777216 true false 195 270 210 270 210 225 240 195 195 195
Polygon -1 true false 270 90 300 135 317 129 309 113
Polygon -1 true false 264 115 255 135 238 129 225 90

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

deer
false
8
Polygon -1184463 true false 195 270 210 270 210 225 240 195 195 195
Polygon -1 true false 225 90 210 60 180 45 150 15 180 30 180 0 195 30 225 0 210 30 225 60 270 45 270 30 255 15 285 30 285 15 300 45 285 45 300 75 270 75
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83
Rectangle -6459832 true false 75 105 210 210
Circle -1 true false 239 101 16
Circle -6459832 true false 132 142 8
Circle -6459832 true false 150 90 120
Polygon -1184463 true false 233 105 255 150 270 150 293 105
Circle -1184463 true false 229 57 67
Rectangle -1184463 true false 164 208 179 283
Polygon -1184463 true false 45 270 30 270 30 225 15 180 45 195
Circle -6459832 true false 6 101 114
Rectangle -1184463 true false 65 206 80 281
Circle -1184463 true false 221 41 67
Polygon -1184463 true false -75 480 -90 450 -105 435 -75 450 -195 585 -90 510 -90 555 -75 540 -75 525 -75 525 -90 540 -105 585 -105 585
Polygon -1 false false 225 90 210 60 180 45 150 15 180 30 180 0 195 30 225 0 210 30 225 60 270 45 270 30 255 15 285 30 285 15 300 45 285 45 300 75 270 75
Rectangle -955883 true false 60 120 210 135
Rectangle -955883 true false 60 165 210 180
Circle -16777216 true false 240 75 0
Circle -16777216 true false 270 75 0
Polygon -2064490 true false 255 135 270 135 255 120 255 135
Polygon -13345367 true false 240 60 240 60 255 75 240 75 240 60
Polygon -13345367 true false 270 60 270 75 285 75 270 60

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

moose
false
4
Polygon -1 true false 225 75 180 60 210 60 180 45 165 60 165 45 180 30 210 45 195 30 180 30 195 15 210 45 225 30 240 45 255 45 270 30 285 45 300 15 300 45 285 60 300 60 285 75 300 90 255 75
Polygon -6459832 true false 195 285 225 285 240 240 225 210 195 210
Rectangle -6459832 true false 65 210 105 281
Rectangle -6459832 true false 135 210 164 283
Circle -6459832 true false 68 125 88
Circle -16777216 true false 70 95 162
Circle -16777216 true false 150 75 120
Polygon -6459832 true false 45 270 30 270 30 225 15 180 90 195
Circle -16777216 true false 10 105 136
Polygon -7500403 true false 156 355 165 375 182 369 174 353
Polygon -1 true false 129 340 120 360 103 354 111 338
Polygon -1 true false -15 480 -15 480 -60 450 -30 450 0 450 15 450 15 480 15 420 30 450 30 480 0 495 15 495
Polygon -6459832 true false 218 105 240 150 285 180 278 105
Circle -6459832 true false 209 52 76
Circle -1184463 true true 270 150 0
Circle -1184463 true true 195 150 0
Circle -1 true false 270 150 0
Polygon -1 true false 240 105 240 105 225 105 225 90 240 105 240 105
Polygon -1 true false 255 105 255 90 270 105 255 105

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
