package com.mydeveloperplanet.myawslambdajavaplanet;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestHandler;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.util.Map;

public class LambdaJava implements RequestHandler<Map<String, String>, String> {
    private static final Gson GSON = new GsonBuilder().setPrettyPrinting().create();

    @Override
    public String handleRequest(Map<String, String> event, Context context) {
        LambdaLogger logger = context.getLogger();
        String response = "Version 1";

        // log execution details
        logger.log("ENVIRONMENT VARIABLES: " + GSON.toJson(System.getenv()) + System.lineSeparator());
        logger.log("CONTEXT: " + GSON.toJson(context) + System.lineSeparator());
        // process event
        logger.log("EVENT: " + GSON.toJson(event) + System.lineSeparator());
        logger.log("EVENT TYPE: " + event.getClass() + System.lineSeparator());

        // Parse JSON into an object
        Car car = GSON.fromJson(GSON.toJson(event), Car.class);
        logger.log("Car brand: " + car.getBrand() + System.lineSeparator());
        logger.log("Car type: " + car.getType() + System.lineSeparator());

        return response;
    }
}
