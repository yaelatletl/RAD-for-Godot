#ifndef GDNOISE_H
#define GDNOISE_H

#include <Godot.hpp>
#include <Spatial.hpp>

namespace godot {

class gdexample : public godot::GodotScript<Spatial> {
    GODOT_CLASS(Noise)

private:
    float time_passed;

public:
    static void _register_methods();

    gdexample();
    ~gdexample();

    void _process(float delta);
};

}

#endif
