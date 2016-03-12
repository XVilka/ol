; http://standards.freedesktop.org/wm-spec/wm-spec-1.5.html
; http://www-h.eng.cam.ac.uk/help/tpl/graphics/X/X11R5/node25.html
(define-library (lib x11)
  (export
    XOpenDisplay
    XDefaultScreen
    XRootWindow
    XBlackPixel
    XWhitePixel
    XCreateWindow
    XCreateSimpleWindow
    ExposureMask
    KeyPressMask
    XSelectInput
    XMapWindow
    XNextEvent XPending
    XStoreName


   ; GLX (WGL: Windows, CGL: Mac OS X, EGL)
   glXQueryVersion
   glXChooseVisual glXCreateContext glXMakeCurrent glXSwapBuffers
   glXChooseFBConfig glXGetVisualFromFBConfig; glXCreateContextAttribs

   vector->int32
  )

  (import
      (r5rs base) (owl io)
      (owl list) (owl string)
      (owl math)
      (owl pinvoke))
  (begin

(define % (dlopen "libX11.so" RTLD_LAZY))
(define XOpenDisplay (dlsym % type-port "XOpenDisplay" type-string))
(define XDefaultScreen (dlsym % type-int+ "XDefaultScreen" type-port))

(define XRootWindow (dlsym % type-port "XRootWindow" type-port type-int+))
(define XBlackPixel (dlsym % type-port "XBlackPixel" type-port type-int+))
(define XWhitePixel (dlsym % type-port "XWhitePixel" type-port type-int+))

(define XCreateWindow (dlsym % type-port "XCreateWindow"
   type-port ; display
   type-port ; parent Window
   type-int+ type-int+ type-int+ type-int+ ; x y width height
   type-int+ ; border width
   type-int+ ; depth
   type-int+ ; class
   type-port ; visual
   type-int+ ; valuemask
   type-port ; attributes
   ))
(define XCreateSimpleWindow (dlsym % type-port "XCreateSimpleWindow"
   type-port type-port ; display, parent Window
   type-int+ type-int+ type-int+ type-int+ ; x y width height
   type-int+ ; border width
   type-int+ ; border
   type-int+ ; background
   ))

; http://tronche.com/gui/x/xlib/events/mask.html
(define ExposureMask (<< 1 15))
(define KeyPressMask (<< 1 0))
(define XSelectInput (dlsym % type-int+ "XSelectInput" type-port type-port type-int+))

(define XMapWindow (dlsym % type-int+ "XMapWindow" type-port type-port))
(define XNextEvent (dlsym % type-int+ "XNextEvent" type-port type-vector-raw))
(define XPending   (dlsym % type-int+ "XPending"   type-port))

(define XStoreName (dlsym % type-int+ "XStoreName" type-port type-port type-string))

;(define Colormap type-port)
;(define XCreateColormap (dlsym % Colormap "XCreateColormap" type-port type-port type-port type-fix+))

; http://stackoverflow.com/questions/1157364/intercept-wm-delete-window-on-x11
;(define XInternAtom (dlsym % type-port "XInternAtom" type-port type-string type-fix+))
;(define XSetWMProtocols (

(define type-int* (fx:or type-int+ #x40))
; -=( wgl )=------------------------------------------------------------
; opengl: https://gist.github.com/gszauer/da038dec2a7ffc288c41
(define GL (dlopen "libGL.so" RTLD_LAZY))
   (define glXQueryVersion  (dlsym GL type-fix+ "glXQueryVersion" type-port type-vector-raw type-vector-raw))

   (define glXChooseVisual  (dlsym GL type-port "glXChooseVisual" type-port type-int+ type-vector-raw))
   (define glXCreateContext (dlsym GL type-port "glXCreateContext" type-port type-port type-int+ type-int+))
   (define glXMakeCurrent   (dlsym GL type-int+ "glXMakeCurrent"  type-port type-port type-port))
   (define glXSwapBuffers   (dlsym GL type-int+ "glXSwapBuffers"  type-port type-port))

   (define glXChooseFBConfig(dlsym GL type-port "glXChooseFBConfig" type-port type-int+ type-vector-raw type-vector-raw)) ; minimal 1.3
   (define glXGetVisualFromFBConfig (dlsym GL type-port "glXGetVisualFromFBConfig" type-port type-port))



   (define (vector->int32 vector)
      (+ (<< (ref vector 0) 0)
         (<< (ref vector 1) 8)
         (<< (ref vector 2) 16)
         (<< (ref vector 3) 24)))
))