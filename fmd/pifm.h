#ifndef _FM_PIFM_H_
#define _FM_PIFM_H_

void fm_setup_fm();
void fm_setup_dma( float centerFreq );
void fm_play(short data, float samplerate);
void fm_unsetup_dma();
#endif // _FM_PIFM_H_
