# Technical Task: Slasher Combat System prototype
## Manifest
- Engine    - Godot `3.6.2`, GDScript
- Modeling  - Blender `5.0.1`
- Env Type  - 3D Third-person
- Resources - `.blender` `.glTF` `.png`
  Design    - Graybox
- Main Goal - StateMachine system


## Details
### Vertical slice
- 1 entity class
- 1 weapon class
- 1 plane level
- Movement: PathFinder for enemies, CharacterController for player
- Render: smooth CameraController following, soft entity focusing, lock-on focus

### Controls
- Player movement: `W` `A` `S` `D` & `Up` `Left` `Down` `Right` / `Left Stick`
- Lock-on focusing: `Middle mouse` / `RB`
- Jump: `Space` / `A`
- Dodge: `Shift` / `B`
- Lightweight atеack: `LMB` / `X`
- Heavyweight attack: `RMB` / `Y`

### Battle logic
- Combo system: 
	Chain attack logics defined in State Machine. 
	Input Buffering (combo continues if input is within the specific timing window).
- Hitbox / Hurtbox: 
	Hitboxes are attached to weapon bones and activate only during Active Frames. 
	Support for Knockback, Launch (launcher attacks), and Juggle (air combos).
- Defence: 
	Dodge with i-frames (invincibility frames). Animation cancelling support.
- Style System:
	Dynamic ranking calculation based on attack variety and damage avoidance.
	Progression: `D` < `C` < `B` < `A` < `S` < `SS` < `SSS`.


## Delivery Scope
- By the end of the agreed term, the project may include a demonstrative prototype featuring:
	Plane level and `1–3` test enemies
	Player movement
	Dodging
	Lock-on system
	Ground and launcher combos
	Style Rating system


## Source of Technical Task
Primary source:
- Original Technical Task (Google Docs):
	https://docs.google.com/document/d/1UD4D4OrCbGcKj_opywPuezKiIAMnRZtPFuSVXcsSnT8/edit?usp=drivesdk

Any changes to the original document do not retroactively affect the scope
defined in this repository unless explicitly agreed and committed.