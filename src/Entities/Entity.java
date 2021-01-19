package Mx.Entities;

import Mx.Utils.Location;

abstract public class Entity {
    private final String name;
    private boolean referred;
    private final Location location;

    public Entity(String name, Location location) {
        this.name = name;
        this.referred = false;
        this.location = location;
    }

    public String getName() {
        return name;
    }
    public Location getLocation() {
        return location;
    }
    public boolean isReferred() {
        return referred;
    }
    public void setReferred() {
        referred = true;
    }
}
