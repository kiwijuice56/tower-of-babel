#tower-of-babel
The Tower of Babel is a work-in-progress Shin Megami Tensei fangame, created with Godot, Aseprite, and Blender.

## Code Guidelines

### User Interface Structure
The user interface (UI) is structured using a state machine. States are created for possible UI contexts, such as within a battle or dialogue in the overworld. Since the comp menu is central to most contexts, a state machine is a clean and flexible solution to implement the variety of transitions and animations needed.

To handle implementation details, sections of UI are abstracted into scenes named `components` with a script that allows for easy external control. Since components are almost completely standalone, nodes across the game can use the interface on each component to display information without error. 

The UI state machine only handles the display and organization of components on the screen, in addition to some internal transitions. Components themselves are expected to be independent and update dynamically when possible. Although the machine is usually passive (as in, other nodes will prompt its transitions), entering and exiting states are paired with signals to orient some data that must be coordinated with the UI state.

### Component Methods
Any initialization methods should be named `initialize` with a varying amount of parameters. Any methods to reset state should be named `clear`. Unless a component completes transitions automatically, any methods related to transitions must be coroutines named `transition_in` and `transition_out`. This standardization promotes a consistent method to handle components even when their functionality is different. Other interface methods on a component should have a descriptive name, such as `display_text` or `handle_action`.

### Code Order
In general, the order of code structures should be:
- `class_name MyClass`
- `extends AnotherClass`
- `const` and `enum`
- `@export` variables
- `@onready` variables
- virtual methods
- signal methods
- any other methods

### Notes
The rules above are only guidelines. There may be some mistakes in the code or better approaches to certain problems. If you see any glaring issues, raise it on this repository. Thank you!