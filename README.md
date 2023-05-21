#tower-of-babel
The Tower of Babel is a work-in-progrses Shin Megami Tensei fangame, created with Godot, Aseprite, and Blender.


## User Interface
The user interface (UI) is structered using a finite-state machine. States are created for the possible menu contexts, such as within a battle or the overworld. Since the COMP menu is central to each context, a state machine is a clean and flexible solution that reduces repetition within the code. 

To handle implementation details, sections of UI are abstracted into scenes with a script that allows for easy external control. For clarity, scenes that abstract UI detail are called "components" within the code. Since components are almost standalone (barring specific components that make no sense without context, such as skill lists), nodes across the game can use the interface on each component to display information without error. 