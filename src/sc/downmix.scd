(
s.waitForBoot({
	"Begining downmixing...".postln;
	m = NetAddr("127.0.0.1", NetAddr.langPort);

	SynthDef(\downmix, {| in = 0, out = 0, centerAmp = 1, frontAmp = 0.7, backAmp = 0.7 |
		var fL, fR, fC, lF, bL, bR;
		fL = In.ar(in, 1);
		fR = In.ar(in + 1, 1);
		fC = In.ar(in + 2, 1);
		lF = In.ar(in + 3, 1);
		bL = In.ar(in + 4, 1);
		bR = In.ar(in + 5, 1);

		Out.ar(out, Mix.new([ [fC * centerAmp, fC * centerAmp], [fL * frontAmp, fR * frontAmp], [bL * backAmp, bR * backAmp] ]));
	}).add;

	x = Synth(\downmix, [\out, 0, \in, 2]);

	OSCdef(\famp, { |msg, time, addr, recvPort|
		msg.postln;
		x.set(\frontAmp, msg[1]);
	}, '/amp/front', m);

	OSCdef(\bamp, { |msg, time, addr, recvPort|
		msg.postln;
		x.set(\backAmp, msg[1]);
	}, '/amp/back', m);

	OSCdef(\camp, { |msg, time, addr, recvPort|
		msg.postln;
		x.set(\centerAmp, msg[1]);
	}, '/amp/center', m);
});
)