# AIRBALL

![Game splash screen](/Source/Images/card.png "Game splash screen")

Hit nothing but net for some serious points

## How to play

Compete against a perfectly-matched opponent (yourself) to get the highest score!

## Controls

- `a` - (hold and release)

## Acknowledgements

TODO

---

## Development

Development of this game requires the [playdate SDK](https://play.date/dev/), which includes a compiler CLI and device simulator.

### Architecture

Documentation on the architecture of this game can be found in the [Architecture folder](./Architecture/).

### Compiling

The game is compiled with the playdate SDK command-line tool, which accepts an input (Source), and produces an output `.pdx` file (airball.pdx).

```bash
pdc Source airball.pdx
```

> note: the `-s` flag can be used to strip debug from the output (e.g. for a release build)

### Running the game with Playdate Simulator

Once compiled, the game can be run within the simulator by opening the `.pdx` output file.

On macOS you can `open` the `.pdx` file from the terminal, which is very fast

```bash
open airball.pdx
```

### Running the game on an actual Playdate device

Once the game is running within the simulator, make sure your playdate is connected and turned on.

Choose "Upload Game to Device" from the Simulator's "Device" menu.

> note: the "Device" menu only appears when a playdate is connected
