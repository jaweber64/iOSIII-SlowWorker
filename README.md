# iOSIII-SlowWorker
iOS App Dev III:  - run two simple tasks at the same time.  

This project is from Chapter 15 of the book "Beginning iPhone Development with Swift -
Exploring the iOS SDK".  Grand Central Dispatch, Background Processing and You.

This project simulates some different tasks that all really just sleep for a specified
amount of time and then return something.  If they are all run sequentially, it takes
about 10 seconds, but if they are run at the same time, it takes only 7 seconds.

Also implemented are aesthetics for the user (i.e. button cannot be pressed again
until all tasks are complete and spinner indicates work is being done).
