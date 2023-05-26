# Tower of Babel
Tower of Babel is a work-in-progress Shin Megami Tensei fangame, created with Godot, Aseprite, and Blender.

# Game Progress
[X] Basic game architecture setup (state machine logic)
[X] Basic combat and action system setup (skills, tactics, fighters, elements, status, etc.)
[X] UI style and architecture setup
[X] Basic text and input help displays
[X] Basic dungeon navigation
[X] Basic pause menu and transitions
[X] Press turn UI 
[X] Fighter status HUD
[X] Action menus and usage validation (enough health/stamina, targets available)
[ ] (IP) Encounter system and radar display
[ ] (IP) Party management and matching UI
[ ] (IP) UI polish and sound effects
[ ] Items in action menus and game structure
[ ] Transition to and from battle (excluding level-up screens for now)
[ ] Basic battle flow and committing actions
[ ] Basic attack animations
[ ] Fighter status screen
[ ] Fighter experience widgets
[ ] Fighter level up and skill learning
[ ] Save file implementation
[ ] Terminal and SaveFile state
[ ] Further dungeon navigation, such as NPC and item pickups 
[ ] Cutscenes
[ ] Demon dialogue trees, develop tactics
[ ] Shop state
[ ] Option state
[ ] Demon fusion system
[ ] Cathedral state and its UI


# Code Documentation

## Game States
The game is organized into distinct states, each with their own logic on controlling the flow of the game.

![Diagram of the flow of game logic](docs/state_machine_flow.png "State Machine Flow Diagram")

## Game Domains
In order to make game state more manageable, the node tree is split into three distinct "roots" of gameplay domains. These root nodes do not implement logic themselves and instead act as an interface to children nodes that handle the details of each domain. Some nodes exist outside of this trio, but only implement small and specific parts of the code.

### User Interface (UI)
Menus and displays of game state/data.

### World
2D and 3D dungeon gameplay.

### Combat
Battles and party state outside of combat.

## UI Structure
The UI code is organized into four "imaginary" interfaces as described below. Godot does not support actual interfaces, hence them being imaginary. However, these descriptions standardize the structure and function of all UI scenes in the game.

### `Component`
Base interface for all UI scenes. It is not necessary for a component to contain any of these functions, but a component should adhere to the headers when implementing a method with similar functionality.

- `[for transition_in and transition_out] signal completed`
- `func initialize(Variant data ...) -> void`
- `func clear() -> void`
- `[coroutine] func transition_in() -> void`
- `[coroutine] func transition_out() -> void`

### `Unit [Button, Icon] extends Component`
A small, immutable and instantiable representation of some sort of information. Units should not be standalone, but rather controlled entirely by some parent component that initializes them. Container units can have other unit children, but they should not manage the visibility or state of those units

### `Widget extends Component`
A small, instantiable representation of some sort of information. Widgets are the same as units, except that they are mutable and usually represent a constantly changing state. Widgets should not handle other components.

### `Handler extends Component`
A controller object that manages the appearance of other components, especially units. Handlers are characterized by having multiple states, set externally through methods. Any methods that accept input from the player should have the prefix `query`.

## Code Order
In general, the order of code structures should be:
- `class_name MyClass`
- `extends AnotherClass`
- `const`
- `enum`
- `@export` variables
- `@onready` variables
- state variables
- virtual methods
- signal methods
- other methods
