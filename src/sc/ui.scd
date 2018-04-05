(
m = NetAddr("127.0.0.1", NetAddr.langPort);

w = Window("PiDownmix", Rect(200, 200, 640, 250)).front;
w.view.decorator = FlowLayout(w.view.bounds, gap: 20@5);
ServerMeterView.new(s, w.view, 0@0, 6, 2);
f = EZKnob(w.view, 70@150, "Front", initVal: 0.7);
c = EZKnob(w.view, 70@150, "Center", initVal: 1);
b = EZKnob(w.view, 70@150, "Back", initVal: 0.7);

f.action = {|ez|
	m.sendMsg("/amp/front", ez.value);
};

c.action = {|ez|
	m.sendMsg("/amp/center", ez.value);
};

b.action = {|ez|
	m.sendMsg("/amp/back", ez.value);
};
)
