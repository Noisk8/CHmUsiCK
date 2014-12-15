//
//  SynthClass.ck
//  CHmUsiCK
//
//  Created by Esteban Betancur on 18/10/14.
//  Copyright (c) 2014 Esteban Betancur. All rights reserved.
//


public class Harmony extends CHmUsiCK
{  
    Gain Normalize => Gain vol => Master => outlet;
    
    0.035 => Normalize.gain; // don't change this
    
    Notes chords;

    3 => int numVoices;
    
    string Notes[0];

    public float gain(float volum)
    {
        volum => vol.gain;
        return vol.gain();
    }
    public float gain()
    {
        return vol.gain();
    }
    public int voices(int num)
    {
        num => numVoices;
        return numVoices;
    }
    public int voices()
    {
        return voices(numVoices);
    }
    public int measure(int num)
    {
        num => Measure;
        return Measure;
    }
    public int measure()
    {
        return measure(Measure);
    }
    public string[] setNotes(string notes[])
    {
        notes @=> Notes;
        return Notes; 
    }
    public string[] setNotes()
    {
        return Notes;
    }
    public string[] random(int capacity)
    {
        string progression[0];
        
        chords.key(chords.randomNote()) @=> string notes[];
        
        for(0 => int i; i < capacity ; i++)
        {
            progression << notes[Math.random2(0,(notes.cap()-1))];
        }  
        return progression;
    }
    public string[] random(int capacity, string Key)
    {
        string progression[0];
        
        for(0 => int i; i < capacity ; i++)
        {
            progression << chords.key(Key)[Math.random2(0,(chords.key(Key).cap()-1))];
        }  
        return progression;
    }
    public void randomHarmony()
    {
        sinOsc(convert(Tempo),random(Math.random2(0,16)),numVoices);
    }
    public void randomHarmony(int capacity)
    {
        sinOsc(convert(Tempo),random(capacity),numVoices);
    }
    public void randomHarmony(float beat, int capacity)
    {
        sinOsc(convert(beat),random(capacity),numVoices);
    }
    public void randomHarmony(dur beat, int capacity)
    {
        sinOsc(beat,random(capacity),numVoices);
    }
    public void randomHarmony(float beat, int capacity, int voices)
    {
        sinOsc(convert(beat),random(capacity),voices);
    }
    public void randomHarmony(dur beat, int capacity, int voices)
    {
        sinOsc(beat,random(capacity),voices);
    }
    public void randomHarmony(float beat, int capacity, string key, int voices)
    {
        sinOsc(convert(beat),random(capacity,key),voices);
    }
    public void randomHarmony(dur beat, int capacity, string key, int voices)
    {
        sinOsc(beat,random(capacity,key),voices);
    }
    public void sinOsc(string note[])
    {
        sinOsc(convert(Tempo),note,numVoices);
    }
    public void sinOsc(dur beat,string note[])
    {
        sinOsc(beat,note,numVoices);
    }
    public void sinOsc(float beat,string note[])
    {
        sinOsc(convert(beat),note,numVoices);
    }
    public void sinOsc(float beat,string note[], int voices)
    {
        sinOsc(convert(beat),note,voices);
    }
    public void sinOsc(dur beat,string note[],int voices)
    {
        convertD(beat) => Tempo;
        voices => numVoices;
        setNotes(note);
        
        (beat * Measure) => dur temp;
        
        SinOsc polyphony[voices];
        for (0 => int i; i < polyphony.cap(); i++)
        {
            polyphony[i] => Normalize;
        }  
        
        while(true)
        {
            for (0 => int i; i < note.cap(); i++)
            {
                chords.voicing(note[i]) @=> int harmony[];
                 
                for(0 => int i; i < polyphony.cap(); i++)
                {
                    Std.mtof(harmony[i]) => polyphony[i].freq;                
                }
                temp => now;  
            }
        }
    }
    public void sqrOsc(string note[])
    {
        sqrOsc(convert(Tempo),note,numVoices);
    }
    public void sqrOsc(float beat, string note[])
    {
        sqrOsc(convert(beat),note,numVoices);
    }
    public void sqrOsc(dur beat, string note[])
    {
        sqrOsc(beat,note,numVoices);
    }
    public void sqrOsc(float beat, string note[], int voices)
    {
        sqrOsc(convert(beat),note,voices);
    }
    public void sqrOsc(dur beat,string note[],int voices)
    {
        convertD(beat) => Tempo;
        voices => numVoices;
        setNotes(note);
        
        (beat * Measure) => dur temp;
        
        SqrOsc polyphony[voices];
        for (0 => int i; i < polyphony.cap(); i++)
        {
            polyphony[i] => Normalize;
        }   
        while(true)
        {
            for (0 => int i; i < note.cap(); i++)
            {
                chords.voicing(note[i]) @=> int harmony[];
                 
                for(0 => int i; i < polyphony.cap(); i++)
                {
                    Std.mtof(harmony[i]) => polyphony[i].freq;                
                }
                temp => now;  
            }
        }
    }
    public void triOsc(string note[])
    {
        triOsc(convert(Tempo),note,numVoices);
    }
    public void triOsc(float beat, string note[])
    {
        triOsc(convert(beat),note,numVoices);
    }
    public void triOsc(dur beat, string note[])
    {
        triOsc(beat,note,numVoices);
    }
    public void triOsc(float beat, string note[], int voices)
    {
        triOsc(convert(beat),note,voices);
    }
    public void triOsc(dur beat, string note[],int voices)
    {
        convertD(beat) => Tempo;
        voices => numVoices;
        setNotes(note);
        
        (beat * Measure) => dur temp;
        
        TriOsc polyphony[voices];
        for (0 => int i; i < polyphony.cap(); i++)
        {
            polyphony[i] => Normalize;
        }  
        while(true)
        {
            for (0 => int i; i < note.cap(); i++)
            {
                chords.voicing(note[i]) @=> int harmony[];
                   
                for(0 => int i; i < polyphony.cap(); i++)
                {
                    Std.mtof(harmony[i]) => polyphony[i].freq;                
                }
                temp => now;  
            }
        }
    }
    public void sawOsc(string note[])
    {
        sawOsc(convert(Tempo),note,numVoices);
    }
    public void sawOsc(float beat, string note[])
    {
        sawOsc(convert(beat),note,numVoices);
    }
    public void sawOsc(dur beat, string note[])
    {
        sawOsc(beat,note,numVoices);
    }
    public void sawOsc(float beat, string note[], int voices)
    {
        sawOsc(convert(beat),note,voices);
    }
    public void sawOsc(dur beat, string note[],int voices)
    {
        convertD(beat) => Tempo;
        voices => numVoices;
        setNotes(note);
        
        (beat * Measure) => dur temp;
        
        SawOsc polyphony[voices];
        for (0 => int i; i < polyphony.cap(); i++)
        {
            polyphony[i] => Normalize;
        }  
        while(true)
        {
            for (0 => int i; i < note.cap(); i++)
            {
                chords.voicing(note[i]) @=> int harmony[];
                   
                for(0 => int i; i < polyphony.cap(); i++)
                {
                    Std.mtof(harmony[i]) => polyphony[i].freq;                
                }
                temp => now;  
            }
        }
    }
    public void pulseOsc(string note[])
    {
        pulseOsc(convert(Tempo),note,numVoices);
    }
    public void pulseOsc(float beat, string note[])
    {
        pulseOsc(convert(beat),note,numVoices);
    }
    public void pulseOsc(dur beat, string note[])
    {
        pulseOsc(beat,note,numVoices);
    }
    public void pulseOsc(float beat, string note[], int voices)
    {
        pulseOsc(convert(beat),note,voices);
    }
    public void pulseOsc(dur beat, string note[],int voices)
    {
        convertD(beat) => Tempo;
        voices => numVoices;
        setNotes(note);
        
        (beat * Measure) => dur temp;
        
        PulseOsc polyphony[voices];
        for (0 => int i; i < polyphony.cap(); i++)
        {
            polyphony[i] => Normalize;
        }
        while(true)
        {
            for (0 => int i; i < note.cap(); i++)
            {
                chords.voicing(note[i]) @=> int harmony[];
                   
                for(0 => int i; i < polyphony.cap(); i++)
                {
                    Std.mtof(harmony[i]) => polyphony[i].freq;                
                }
                temp => now;  
            }
        }
    }
}