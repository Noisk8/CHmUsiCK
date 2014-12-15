//
//  MelodyClass.ck
//  CHmUsiCK
//
//  Created by Esteban Betancur on 18/10/14.
//  Copyright (c) 2014 Esteban Betancur. All rights reserved.
//

public class Melody extends CHmUsiCK
{   
    Gain Normalize => Gain vol => Master => outlet;
    
    0.25 => Normalize.gain; //don't change this
    
    ADSR envelope;
    
    SinOsc sin; SqrOsc sqr; PulseOsc pulse; SawOsc saw;TriOsc tri;
    [sin,sqr,pulse,saw,tri] @=> Osc osc[];
    
    0 => int activeOsc;
    
    BlowBotl BB; BandedWG BWG; Wurley W; TubeBell TB; Bowed bow;
    Rhodey rhod; PercFlut PF; BlowHole BH; HevyMetl HM; ModalBar MB;
    Flute flut; Mandolin mandol; Saxofony sax; Moog mg; Sitar sit; 
    StifKarp SK; BeeThree BT; FMVoices fmv;
    [BB, BWG,W,TB,bow,rhod,PF,BH,flut,mandol,MB,mg,sax,sit,SK,BT,fmv,HM] @=> StkInstrument inst[];
    
    0 => int activeInst; 

    8 => int Division;
    
    int Notes[0];
    
    //———————————-envelope————————————//
    10::ms => dur A;
    8::ms => dur D;
    0.5 => float S;
    5::ms => dur R;
    
    envelope.set(A, D, S, R);
    
    public float gain(float volum)
    {
        volum => vol.gain; 
        return vol.gain();
    }
    public float gain()
    {
        return vol.gain();
    }
    public int subdivision(int div)
    {
        div => Division;
        return Division;
    }
    public int subdivision()
    {
        return Division;
    }
    public int[] setNotes(int notes[])
    {
        notes @=> Notes;
        return Notes; 
    }
    public int[] setNotes()
    {
        return Notes;
    }
    public dur attack(dur attacK)
    {
        attacK => A;
        return A;
    }
    public dur attack()
    {
        return attack(A);
    }
    public dur decay(dur decaY)
    {
        decaY => D;
        return D;
    }
    public dur decay()
    {
        return decay(D);
    }
    public float sustain(float sustaiN)
    {
        sustaiN => S;
        return S;
    }
    public float sustain()
    {
        return sustain(S);
    }
    public dur release(dur releasE)
    {
        releasE => R;
        return R;
    }
    public dur release()
    {
        return release(R);
    }
    public int controlChangeOsc(int parameter)
    {
        parameter => activeOsc;
        if(parameter == 0) 0.5 => Normalize.gain;
        if(parameter == 1) 0.19 => Normalize.gain;
        if(parameter == 2) 0.19 => Normalize.gain;
        if(parameter == 3) 0.19 => Normalize.gain;
        if(parameter == 4) 0.45 => Normalize.gain;
        return activeOsc;
    }
    public int controlChangeOsc()
    {
        return controlChangeOsc(activeOsc);
    }
    public int controlChange(int parameter)
    {
        if(parameter == 0) 0.25 => Normalize.gain;
        if(parameter == 1) 4.5 => Normalize.gain;
        if(parameter == 2) 0.35 => Normalize.gain;
        if(parameter == 3) 0.35 => Normalize.gain;
        if(parameter == 4) 3 => Normalize.gain;
        if(parameter == 5) 0.45 => Normalize.gain;
        if(parameter == 6) 0.45 => Normalize.gain;
        if(parameter == 7) 0.3 => Normalize.gain;
        if(parameter == 8) 0.35 => Normalize.gain;
        if(parameter == 9) 0.4 => Normalize.gain;
        if(parameter == 10) 1 => Normalize.gain;
        if(parameter == 11) 1 => Normalize.gain;
        if(parameter == 12) 0.2 => Normalize.gain;
        if(parameter == 13) 0.8 => Normalize.gain;
        if(parameter == 14) 0.35 => Normalize.gain;
        if(parameter == 15) 0.35 => Normalize.gain;
        if(parameter == 16) 0.25 => Normalize.gain;
        if(parameter == 17) 0.35 => Normalize.gain;

        parameter => activeInst;
        return activeInst;
    }
    public int controlChange()
    {
        return controlChange(activeInst);
    }
    public int[] random(int capacity)
    {
        int melody[capacity];
        
        Notes harmony;
        harmony.voicing(harmony.randomNote()) @=> int notes[];
        
        for(0 => int i; i < melody.cap(); i++)
        {
            notes[Math.random2(0,(notes.cap()-1))] @=> melody[i];
        }  
        return melody;
    }
    public int[] random(string key, int capacity)
    {
        int melody[capacity];
        
        Notes harmony;
        harmony.voicing(key) @=> int notes[];
        
        for(0 => int i; i < melody.cap(); i++)
        {
            notes[Math.random2(0,(notes.cap()-1))] @=> melody[i];
        }  
        return melody;
    }
    public void randomMelody()
    {
        controlChange(Math.random2(0,17));
        Math.random2(0,Math.random2(0,64)) => int capacity;
        synth(convert(Tempo),Division,random(capacity));
    }
    public void randomMelody(int capacity)
    {
        controlChange(Math.random2(0,17));
        synth(convert(Tempo),Division,random(capacity));
    }
    public void randomMelody(float beat ,int capacity)
    {
        controlChange(Math.random2(0,17));
        synth(convert(beat),Division,random(capacity));
    }
    public void randomMelody(dur beat ,int capacity)
    {
        controlChange(Math.random2(0,17));
        synth(beat,Division,random(capacity));
    }
    public void randomMelody(float beat, int div ,int capacity)
    {
        controlChange(Math.random2(0,17));
        synth(convert(beat),Division,random(capacity));
    }
    public void randomMelody(dur beat, int div ,int capacity)
    {
        controlChange(Math.random2(0,17));
        synth(beat,div,random(capacity));
    }
    public void randomMelody(float beat, int div ,int capacity, string key)
    {
        controlChange(Math.random2(0,17));
        synth(convert(beat),div,random(key,capacity));
    }
    public void randomMelody(dur beat, int div ,int capacity, string key)
    {
        controlChange(Math.random2(0,17));
        synth(beat,div,random(key,capacity));
    }
    //———————————————synth——————————————//
    public void synthOsc()
    {
        synthOsc(convert(Tempo),Division,Notes);
    }
    public void synthOsc(int notes[])
    {
        synthOsc(convert(Tempo),Division,notes);
    }
    public void synthOsc(float beat,int notes[])
    {
        synthOsc(convert(beat),Division,notes);
    }
    public void synthOsc(dur beat,int notes[])
    {
        synthOsc(beat,Division,notes);
    }
    public void synthOsc(float beat,int div,int notes[])
    {
        synthOsc(convert(beat),div,notes);
    }
    public void synthOsc(dur beat,int div,int notes[])
    {
        convertD(beat) => Tempo;
        div => Division;
        setNotes(notes);
        
        osc[activeOsc] => envelope => Normalize;
        
        while(true)
        {
            for(0 => int i; i < notes.cap(); i++)
            {
                if(notes[i] == 0)
                {
                    envelope.keyOff();
                    Dur(beat,div) => now;
                }
                else
                {
                    Std.mtof(notes[i]) => osc[activeOsc].freq;
                    envelope.keyOn();
                    Dur(beat,div) => now;
                    envelope.keyOff();
                }
            }          
        }
    }
    public void synth()
    {
        synth(convert(Tempo),Division,Notes);
    }
    public void synth(int notes[])
    {
        synth(convert(Tempo),Division,notes);
    }
    public void synth(float beat,int notes[])
    {
        synth(convert(beat),Division,notes);
    }
    public void synth(dur beat,int notes[])
    {
        synth(beat,Division,notes);
    }
    public void synth(float beat,int div,int notes[])
    {
        synth(convert(beat),div,notes);
    }
    public void synth(dur beat,int div,int notes[])
    {
        convertD(beat) => Tempo;
        div => Division;
        setNotes(notes);
        
        inst[activeInst] => Normalize;
        
        while(true)
        {
            for(0 => int i; i < notes.cap(); i++)
            {
                if(notes[i] == 0)
                {
                    inst[activeInst].noteOff;
                    Dur(beat,div) => now;
                }
                else
                {
                    Std.mtof(notes[i]) => inst[activeInst].freq;
                    1 => inst[activeInst].noteOn;
                    inst[activeInst].noteOn;
                    Dur(beat,div) => now;
                    inst[activeInst].noteOff;
                }
            }          
        }
    }
}