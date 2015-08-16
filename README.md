Task:
-----
Create a sample MVC(S) Robotlegs project using Robotlegs version 1.5.2. The
project must implement the following concepts. Please make sure the concepts
are implemented in a practical and meaningful way.
 * Context
 * Model
 * View
 * Mediator
 * Controller (Command)
 * Service
 * Factory
 * Interface
 * Signals
 * Unit tests
 * Tweens (using Greensock)

You are free to choose the functionality of the application if you think
another application would showcase the above concepts better, but an example
of what we expect would be an application that loads images and presents them
in a collage-like fashion (calculate the optimal layout based on each images
aspect ratio to obtain the minimal unused screen space). After an image is
clicked, it fades-out and is removed from the collage and another image is
loaded, fades-in, and the layout is updated.
The removed images must get garbage-collected.

We will be looking at your ability to understand the concepts and utilize them
in a practical way. Code readability (variable naming, code formatting),
simplicity and modularity are values we will be looking for. Also animation
skills and tying animations into the otherwise synchronous state machine.

Please host this project on GitHub to showcase your knowledge of Git.

Extra task.
-----------
Create a Maven configuration pom.xml for the project. It should include a test
runner and working build config.

Extra task.
-----------
Write method that takes two sorted arrays of integers (can be of any range,
numbers can repeat, sizes of arrays can be different) and returns array of n + m
length which is sorted in the same order. Do not use any type of built-in sorting.

Extra question
--------------
Explain what does this code do, how it works and what's wrong with it:

var xmlData:XML = 
   <root>
      <node myVal="1">data</node>
      <node myVal="2"> data </node>
      <node myVal="3"> data </node>
      <node myVal="4"> data </node>
      <node myVal="5"> data </node>
   </root>;

xmlData.children().(@myVal % 2 && trace(@myVal));