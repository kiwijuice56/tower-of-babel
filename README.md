# Tower of Babel
Tower of Babel is a work-in-progress Shin Megami Tensei fangame, created with Godot, Aseprite, and Blender.

# Code Guidelines

## Game States
The game is organized into distinct states, each with their own logic on controlling the flow of the game.

![Diagram of the flow of game logic](docs/state_machine_flow.png "State Machine Flow Diagram")

## Game Domains
In order to make game state more managable, the node tree is split into tree distinct "roots" of different gameplay domains. These root nodes do not implement logic themselves and instead act as an interface to children nodes that handle the details of each domain. Some nodes exist outside of this trio, but only implement small and specific parts of the code.

### User Interface (UI)
Menus and displays of game state/data.

### World
2D and 3D dungeon gameplay.

### Combat
Battles and party state outside of combat.

## UIStructure
The UI code is organized into four "imaginary" interfaces as described below. Godot does not support actual interfaces, hence them being imaginary. However, these descriptions standardize the structure and function of all UI scenes in the game.

### Component
Base interface for all UI scenes. It is not necessary for a component to contain any of these functions, but a component should adhere to the headers when implementing a method with similar functionality.

- `[for transition_in and transition_out] signal completed`
- `func initialize(Variant data ...) -> void`
- `func clear() -> void`
- `[coroutine] func transition_in() -> void`
- `[coroutine] func transition_out() -> void`

### Unit [Button, Icon] extends Component
A small, immutable and instantiable representation of some sort of information. Units should not be standalone, but rather controlled entirely by some parent component that initializes them. Container units can have other unit children, but they should not manage the visibility or state of those units

### Widget extends Component
A small, instantiable representation of some sort of information. Widgets are the same as units, except that they are mutable and usually represent a constantly changing state. Widgets should not handle other components.

### Handler extends Component
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
