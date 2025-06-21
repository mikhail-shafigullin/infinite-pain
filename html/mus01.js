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


