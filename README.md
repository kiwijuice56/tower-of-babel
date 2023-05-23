# tower-of-babel
The Tower of Babel is a work-in-progress Shin Megami Tensei fangame, created with Godot, Aseprite, and Blender.

## Code Guidelines

### User Interface Structure
The user interface (UI) is structured using a state machine. States are created for possible UI contexts, such as within a battle or dialogue in the overworld. Since the comp menu is central to most contexts, a state machine is a clean and flexible solution to implement the variety of transitions and animations needed.

To handle implementation details, sections of UI are abstracted into scenes named `components` with a script that allows for easy external control. Since components are almost completely standalone, nodes across the game can use the interface on each component to display information without error. 

The UI state machine only handles the display and organization of components on the screen, in addition to some internal transitions. Components themselves are expected to be independent and update dynamically when possible. Although the machine is usually passive (as in, other nodes will prompt its transitions), entering and exiting states are paired with signals to orient some data that must be coordinated with the UI state.

To summarize, the state machine will mainly concern itself with internal state and display of components. Its role is to call methods on self-contained components to properly animate and transition their visibility. It should use API on components unrelated to visibility as little as possible, but exceptions can be made for prompts to transition to different UI states.

### Component Methods

#### Transitions
Any methods related to transitions must be coroutines named `transition_in` and `transition_out`. However, these methods should only be declared if the UI state machine is expected to handle this behavior. Otherwise, add a `_` prefix or implement it inline. This is in order to prevent confusion of how transitions should be handled.

#### Clear 
Any initialization methods should be named `initialize` with a varying amount of parameters. Any methods to reset state should be named `clear`.

### Code Order
In general, the order of code structures should be:
- `class_name MyClass`
- `extends AnotherClass`
- `const` and `enum`
- `@export` variables
- `@onready` variables
- any other variables
- virtual methods
- signal methods
- any other methods

### Notes
The rules above are only guidelines. There may be some mistakes in the code or better approaches to certain problems. If you see any glaring issues, raise it on this repository. Thank you!

## TODO:
- [X] Add targeting to FighterPanel
- [] Complete DemonContainer and tie together with dungeon menu
- [] Complete DemonStatusScreen
- [] Implement random encounters, including enemy positioning, encounter tile system, and the battle control process
- [] Complete TargetSelection 
- [] Flesh out skill hierarchy
- [] Complete SubactionPanel, both within and outside of combat
- [] Implement BattleQueue, starting with pass action
- [] Add basic attacking skills and animation
- [] Design UI sound effects
- [] Add basic healing items  and animation
- [] Add basic status skills (buffs, inflicting conditions) and complete BuffPanel
- [] Design a system for demon dialogue and implement talking skills
- [] Add basic examples of talking skills
- [] Implement experience widgets, customizing stats, and learning skills
- [] Implement SaveFile system
- [] Add TerminalScreen for saving the game
- [] Flesh out Dungeon features, such as talking to NPCs and interacting with spots
- [] Music