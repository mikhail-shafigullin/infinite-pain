
// TODO: refactor to use newer version without controls import
// import { controls, repl, evalScope } from 'https://cdn.skypack.dev/@strudel/core@0.11.0';
// import { mini } from 'https://cdn.skypack.dev/@strudel/mini@0.11.0';
// import { transpiler } from 'https://cdn.skypack.dev/@strudel/transpiler@0.11.0';
// import {
//     getAudioContext,
//     webaudioOutput,
//     initAudioOnFirstClick,
//     registerSynthSounds,
// } from 'https://cdn.skypack.dev/@strudel/webaudio@0.11.0';

// const ctx = getAudioContext();

// const loadModules = evalScope(
//   controls,
//   import('https://cdn.skypack.dev/@strudel/core@0.11.0'),
//   import('https://cdn.skypack.dev/@strudel/mini@0.11.0'),
//   import('https://cdn.skypack.dev/@strudel/tonal@0.11.0'),
//   import('https://cdn.skypack.dev/@strudel/webaudio@0.11.0'),
// );

// const initAudio = Promise.all([initAudioOnFirstClick(), registerSynthSounds()]);

// const { evaluate } = repl({
//     defaultOutput: webaudioOutput,
//     getTime: () => ctx.currentTime,
//     transpiler,
// });
var strudelEditor;

const initAudio = async function () {
  var repl = document.createElement('strudel-editor');
  document.getElementById('strudel').append(repl);
  strudelEditor = repl.editor;
  window.strudelEditor = strudelEditor;
  console.log(strudelEditor);
}

// document.getElementById('strudel').append(repl);

// initStrudel();


const unit_1_0_level_1_drums_notes = "bd"
const unit_1_1_level_1_drums_notes = "[bd <hh oh>]*2"
const unit_1_2_level_1_drums_notes = "[bd <hh oh> sd <lt rim>]*2"
const unit_1_3_level_1_drums_notes = "[bd mt <hh oh> bd sd mt <lt rim> sd]*2"

const unit_1_level_1_drums_bank = "ace"

const unit_2_0_level_1_drums_notes = "- hh"
const unit_2_1_level_1_drums_notes = "[bd <hh oh>]*2"
const unit_2_2_level_1_drums_notes = "[bd <hh oh> sd <lt rim>]*2"
const unit_2_3_level_1_drums_notes = "[hh hh <hh oh> bd rim hh <lt rim> sd]*2"

const unit_2_level_1_drums_bank = "9000"

const units = {
  unit1: {
    drums: [
      unit_1_0_level_1_drums_notes,
      unit_1_1_level_1_drums_notes,
      unit_1_2_level_1_drums_notes,
      unit_1_3_level_1_drums_notes
    ],
    drums_bank: unit_1_level_1_drums_bank,
  },
  unit2:{
    drums: [
      unit_2_0_level_1_drums_notes,
      unit_2_1_level_1_drums_notes,
      unit_2_2_level_1_drums_notes,
      unit_2_3_level_1_drums_notes
    ],
    drums_bank: unit_2_level_1_drums_bank,
  }
}

let str = `
setcpm(120/4)

const unit_1_0_level_1_drums_notes = "bd"
const unit_1_1_level_1_drums_notes = "[bd <hh oh>]*2"
const unit_1_2_level_1_drums_notes = "[bd <hh oh> sd <lt hh>]*2"
const unit_1_3_level_1_drums_notes = "[bd mt <hh oh> bd sd mt <lt hh> sd]*2"

const unit_1_level_1_drums_bank = "ace"

const unit_2_0_level_1_drums_notes = "- hh"
const unit_2_1_level_1_drums_notes = "[bd <hh oh>]*2"
const unit_2_2_level_1_drums_notes = "[bd <hh oh> sd <lt rim>]*2"
const unit_2_3_level_1_drums_notes = "[hh hh <hh oh> bd rim hh <lt rim> sd]*2"

const unit_2_level_1_drums_bank = "9000"

const units = {
  unit1: {
    drums: [
      unit_1_0_level_1_drums_notes,
      unit_1_1_level_1_drums_notes,
      unit_1_2_level_1_drums_notes,
      unit_1_3_level_1_drums_notes
    ],
    drums_bank: unit_1_level_1_drums_bank,
  },
  unit2:{
    drums: [
      unit_2_0_level_1_drums_notes,
      unit_2_1_level_1_drums_notes,
      unit_2_2_level_1_drums_notes,
      unit_2_3_level_1_drums_notes
    ],
    drums_bank: unit_2_level_1_drums_bank,
  }
}

DRUMS_UNIT_1: s(units.unit1.drums[2]) 
  .lpf(1000)
  .bank(units.unit1.drums_bank)
._scope()


DRUMS_UNIT_2: s(units.unit2.drums[0]) 
  .lpf(1000)
  .bank(units.unit2.drums_bank)
._scope()


_GUITAR: n("<0, 2, 4>".sub("<0 2>/4")).sound("gm_overdriven_guitar")
    .scale("[G:minor F:major C:minor D#:major]/4")

VIB: n("<0, 2, 4>".sub("7")).sound("recorder_bass_vib")
  .scale("[G:minor F:major C:minor D#:major]/4")
  ._punchcard({ labels: 1, cycles: 10})

VOCAL: n("<0, 2, 4>".sub("<0 2>/4")).sound("harp")
    .scale("[G:minor F:major <C:minor A:minor> D#:major]/4")
`


var strudel_music = {
    default_music: async () => {
      await strudelEditor.setCode(str);
      await strudelEditor.repl.evaluate(str);
    },

    stop_music: () => strudelEditor.repl.stop(),
}

var godotConnector = {
    async loadStrudel() {
      await initAudio();
    },
    play() {
        console.log("play strudel");
        strudel_music.default_music();
    },
    stop() {
        console.log("stop strudel");
        strudel_music.stop_music();
    },

};

export { units, strudel_music, godotConnector, strudelEditor };
