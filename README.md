# Spin2Win

Game jam submission for **The Very Serious Juniper Dev Game Jam**:  
https://itch.io/jam/theveryseriousjuniperdevgamejam

## About

`Spin2Win` is a small Godot project built for the jam.  
The goal is to keep the scope tight, feel responsive, and deliver a complete playable loop.

## Built With

- Godot Engine (project file: `project.godot`)
- GDScript

## How To Run

1. Open the project in Godot.
2. Load `project.godot` from this folder.
3. Press **Play** to run the game.

## Controls

- Keyboard controls are implemented in-game.
- If you want to tweak controls, check scripts like `player.gd` and input mappings in Godot project settings.

## Project Structure (high level)

- `main.tscn`: Main game scenes
- `player.tscn` + `player.gd`: Player scene and logic
- `autoload/`: Global singleton scripts (`AudioController`, `GameState`, `SceneManager`)

## Jam Notes

- Theme and judging details are available on the jam page.
- This repository contains the source project used for the submission.