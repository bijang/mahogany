(defpackage #:mahogany/backend-interface
  (:use :cl)
  (:export #:set-window-manager
	   #:start-backend
	   #:stop-backend
	   #:cleanup-backend))

(defpackage #:mahogany/wm-interface
  (:use :cl)
  (:export #:output
	   #:output-x
	   #:output-y
	   #:output-width
	   #:output-height
	   #:output-tree
	   #:output-floating-windows
	   #:configure-output
	   ;; view interface:
	   #:view
	   #:view-x
	   #:view-y
	   #:view-opacity
	   #:set-dimensions
	   ;; wm callbacks:
	   #:get-visible-views
	   #:set-backend
	   #:add-view
	   #:add-output
	   #:remove-view
	   #:view-at))

(defpackage #:mahogany/tree
  (:use :cl #:mahogany/log #:alexandria #:mahogany/util #:iterate
	#:mahogany/wm-interface)
  (:export #:*split-frame-hook*
	   #:*new-frame-hook*
	   #:*remove-split-hook*
	   #:*new-split-type*
	   #:frame
	   #:frame-at
	   #:frame-x
	   #:frame-y
	   #:frame-width
	   #:frame-height
	   #:frame-parent
	   #:tree-container
	   #:root-tree
	   #:tree-frame
	   #:tree-children
	   #:tree-split-direction
	   #:binary-tree-frame
	   #:poly-tree-frame
	   #:split-frame-v
	   #:split-frame-h
	   #:remove-frame
	   #:swap-positions
	   #:find-empty-frame
	   #:get-empty-frames
	   #:get-populated-frames
	   #:root-frame-p
	   #:view-frame
	   #:frame-view
	   #:frame-modes
	   #:fit-view-into-frame
	   #:leafs-in))

(defpackage #:mahogany/wm
  (:use :cl #:mahogany/log #:alexandria
	#:mahogany/wm-interface
	#:mahogany/backend-interface
	#:mahogany/tree)
  (:export #:window-manager))

(defpackage #:mahogany/backend
  (:use :cl :cffi #:mahogany/log #:alexandria #:wlr/macros #:wlr/common-c-types
	#:mahogany/backend-interface #:mahogany/wm-interface #:mahogany/tree)
  (:import-from #:wayland-server-core
		#:wl-display-add-socket-auto
		#:wl-display-destroy
		#:wl-display-destroy-clients
		#:wl-display-run
		#:wl-display-terminate
		#:wl-signal-add
		#:wl-list-remove
		#:wl-list-empty
		#:wl_listener
		#:wl_list
		#:prev
		#:notify
		#:link)
  (:import-from #:xkb
		#:with-xkb-context
		#:with-keymap-from-names)
  (:export #:get-server))

(defpackage #:mahogany
  (:use :cl #:mahogany/log #:alexandria #:mahogany/wm-interface
	#:mahogany/backend-interface
	#:mahogany/tree)
  (:export #:*wm* #:*backend*))
