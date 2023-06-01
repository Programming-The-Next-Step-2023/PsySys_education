# PsySys app

This repository contains the PsySys R package which contains an R shiny application and was created as a final project for the course "Programming: The Next Step" at the University of Amsterdam. PsySys - Psychological Systems Education - is a network-informed psychoeducation aimed at helping individuals to better understand and deal with their mental-health. The shiny application transforms the psychoeducative content into an interactive learning experience in which the user creates their own perceived causal network (hereinafter: mental-health map). 

By working through four blocks containing both a short explanation video and an exercise the user gradually builds their map in a modular way, whereby the user received direct visual feedback after every step allowing them to not only immediately access their final map, but also track their progress along the way. Throughout the session, the user selects the factors they are currently dealing with, indicate causal chains and cycles between them, and choose a promising treatment target for their personal map. Thus, the shiny implementation enables an engaging user experience in a stand-alone and self-explanatory application. Thereby, the PsySys app extends existing methods to assess causal symptom networks, and can be used across a wide span of application ranging from research to practice.

The PsySys package contains then functions which are all exported: <code>startPsySys, map_create_skeleton, map_include_chains, map_include_cycles, map_add_node, map_delete_node, map_add_edge, map_delete_edge, map_highlight_target, map_find_targets</code>. The only function needed for the user to run the app is <code>startPsySys</code> which opens up the user interface. The remaining functions are used to update the map in the background. For more information on their functionality, the reader is referred to their documentation. 

For more information on the scientific rationale behind PsySys and a step-by-step app demonstration, the reader is referred to the vignette. 


