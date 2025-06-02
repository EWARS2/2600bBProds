import sys, pygame
import time
import math
#from array import array
pygame.init()

size = width, height = 320, 120
black = 0, 0, 0
blue = 0, 0, 255

camDirection=1.34
camX=10
camY=10

lvl=[1,1,1,1,1,
     1,0,0,0,1,
     1,0,0,0,1,
     1,0,0,0,1,
     1,1,1,1,1]
lvlHRes=5


screen = pygame.display.set_mode(size)

ball = pygame.image.load("intro_ball.gif")
ballrect = ball.get_rect()

while True:

    ############################## Technical Screendraw Stuffs
    for event in pygame.event.get():
        if event.type == pygame.QUIT: sys.exit()
                
    time.sleep(.01)
    pygame.display.flip() #Refreshes the screen
    screen.fill(black) #Clears the screen
    #############################################


    #########################Temporary object, remove dis
    #screen.blit(ball, ballrect) #Blits the ball onscreen
    #ballrect=(camX,camY)
    ####################################


    ##################################Keyboard Controller
    keys=pygame.key.get_pressed()
    if keys[pygame.K_LEFT]:
        camDirection -= .01
    if keys[pygame.K_RIGHT]:
        camDirection += .01
    tempCos=math.cos(camDirection)
    tempSin=math.sin(camDirection)
    if keys[pygame.K_UP]:
        camX += tempCos
        camY += tempSin
    if keys[pygame.K_DOWN]:
        camX -= tempCos
        camY -= tempSin
    #####################################

    ############ Do the render thing
    L=0 # Needed because C adds this to its heriarchy and makes it unaccessable outside the loop 
    for i in range(-16, 15):
        tempX=camX
        tempY=camY
        tempDirection=camDirection+i
        tempCos=math.cos(tempDirection)
        tempSin=math.sin(tempDirection)
        for L in range (6, 0):
            tempX += tempCos
            tempY += tempSin
            temp = (tempX+(lvlHRes*tempY))/10
            if lvl[temp]==1: #If the raycast is touching a wall
                break
        pygame.draw.rect(screen, blue, (10*(i+17), 10*(6-L), 10, 20*L))
        
    
        



    
