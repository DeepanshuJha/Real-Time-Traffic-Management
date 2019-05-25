# Real-Time-Traffic-Management

Software Requirement:
  1. R Studio
  2. Arduino ide

Hardware Requirement:
  1. Arduino uno microcontroller
  2. IR sensor

Steps:
  1. Run the arduino script.
  2. The values will be sent to R script
  3. It will the predict the time 
  4. It will automatically send the signal to the coressponding traffic signal light to change to green for that amount,
     and others to red.

Misc:

Copy all three files in tha same directory.
Then open R and then please change the path of the train and test file.
After running the file, the result will tell us how much time should be alloted to that lane.
And subsequently all other lanes will be handled.
