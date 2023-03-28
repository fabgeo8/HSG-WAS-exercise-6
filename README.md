# Exercise 6: Agents interacting on the Web

This repository contains a partial implementation of a [JaCaMo](https://github.com/jacamo-lang/jacamo) application where BDI agents interact with their environment based on [W3C Web of Things (WoT) Thing Descriptions](https://www.w3.org/TR/wot-thing-description11/), and coordinate with each other to assist a user through their daily activities.

## Table of Contents
- [Project structure](#project-structure)
- [Task 1](#task-1)
  - [Task 1.1](#task-11)
  - [Task 1.2](#task-12)
  - [Task 1.3](#task-13)
  - [Task 1.4](#task-14)
- [How to run the project](#how-to-run-the-project)


## Project structure
```
├── mockserver
│   └── room-services.json // the initializer for the mockserver that mocks the HTTP APIs of a calendar service, a wristband, a set of blinds, and a set of lights
├── src
│   ├── agt
│   │   ├── personal_assistant.asl // agent program of the personal assistant agent
│   │   ├── wristband_manager.asl // agent program of the wristband manager agent
│   │   ├── calendar_manager.asl // agent program of the calendar manager agent
│   │   ├── blinds_controller.asl // agent program of the blinds controller agent 
│   │   └── lights_controller.asl // agent program of the lights controller agent
│   └── env
│       └── room
│           └── DweetArtifact.java // artifact that can be used for sending messages to agents via the dweet.io API
└── task.jcm // the configuration file of the JaCaMo application
```

## Task 1 

### Task 1.1 
Complete the implementation of following:
- the [`DweetArtifact.java`](src/env/room/DweetArtifact.java) for enabling agents to send messages via the dweet.io API;
- the [`personal_assistant.asl`](src/agt/personal_assistant.asl) so that the personal assistant can create a `DweetArtifact` instance, and achieve the goal of sending a message by using the artifact.
  - HINT: The [CArtAgO By Example guide](https://www.emse.fr/~boissier/enseignement/maop13/courses/cartagoByExamples.pdf) provides documentation and examples on how to program CArtAgO artifacts and their operations, and how to program agents that create artifacts and invoke artifact operations

### Task 1.2
Complete the implementation of following:
- the [`calendar_manager.asl`](src/agt/calendar_manager.asl) can create and interact with an artifact based on the [W3C WoT Thing Description of a calendar service](https://github.com/Interactions-HSG/example-tds/blob/was/tds/calendar-service.ttl);
- the [`blinds_controller.asl`](src/agt/blinds_controller.asl) can create and interact with an artifact based on the [W3C WoT Thing Description of a set of blinds](https://github.com/Interactions-HSG/example-tds/blob/was/tds/blinds.ttl);
- the [`lights_controller.asl`](src/agt/lights_controller.asl) can create and interact with an artifact based on the [W3C WoT Thing Description of a set of lights](https://github.com/Interactions-HSG/example-tds/blob/was/tds/lights.ttl).
  - HINTS:
    -  The repository of the [jacamo-hypermedia](https://github.com/HyperAgents/jacamo-hypermedia) library provides examples on how agents can create and interact with instances of [ThingArtifact.java](https://github.com/HyperAgents/jacamo-hypermedia/blob/main/lib/src/main/java/org/hyperagents/jacamo/artifacts/wot/ThingArtifact.java);
    - In [`wristband_manager.asl`](src/agt/wristband_manager.asl) the agent creates and invokes an operation of a `ThingArtifact`.

### Task 1.3
Complete the implementation of following so that the agents can inform the [`personal_assistant.asl`](src/agt/personal_assistant.asl) about the state of the environment:
- the [`wristband_manager.asl`](src/agt/wristband_manager.asl);
- the [`calendar_manager.asl`](src/agt/calendar_manager.asl);
- the [`blinds_controller.asl`](src/agt/blinds_controller.asl);
- the [`lights_controller.asl`](src/agt/lights_controller.asl).

### Task 1.4
Complete the implementation of following so that the agents can coordinate with each other based on the [FIPA Contract Net Interaction Protocol](http://www.fipa.org/specs/fipa00029/SC00029H.html): 
- the [`personal_assistant.asl`](src/agt/personal_assistant.asl);
- the [`blinds_controller.asl`](src/agt/blinds_controller.asl);
- the [`lights_controller.asl`](src/agt/lights_controller.asl).

## How to run the project
### 1. Run the mockserver that mocks the devices' HTTP APIs

Run [MockServer](https://www.mock-server.com/) with [Docker](https://www.docker.com/):
   ```
   docker run -v "$(pwd)"/mockserver/room-services.json:/tmp/mockserver/room-services.json -e MOCKSERVER_INITIALIZATION_JSON_PATH=/tmp/mockserver/room-services.json -d --rm --name      mockserver -p 1080:1080 mockserver/mockserver
   ```
The above command will run a Docker container in the background and will print the container ID. To stop a container run: `docker stop <CONTAINER_ID>`.
You can use this [Postman collection](https://api.postman.com/collections/2431802-d1600c9e-5b54-4273-b070-19d955c94b46?access_key=PMAT-01GWMVP9FJ4YQPVVCJVYH1M2WM) to inspect the behavior of the devices' mockserver.

### 2. Run the JaCaMo application

You can run the project directly in Visual Studio Code or from the command line with Gradle 7.4.
- In VSCode:  Click on the Gradle Side Bar elephant icon, and navigate through `GRADLE PROJECTS` > `exercise-6` > `Tasks` > `jacamo` > `task`.
- On MacOS and Linux run the following command:
```shell
./gradlew task
```
- On Windows run the following command:
```shell
gradle.bat task
```

