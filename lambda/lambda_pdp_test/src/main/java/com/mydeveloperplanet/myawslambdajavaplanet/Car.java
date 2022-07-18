package com.mydeveloperplanet.myawslambdajavaplanet;

public class Car {
    private Brand brand;
    private String type;

    public Car(Brand brand, String type) {
        this.brand = brand;
        this.type = type;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
