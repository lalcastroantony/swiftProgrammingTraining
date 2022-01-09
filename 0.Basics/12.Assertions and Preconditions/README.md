# 12.Assertions and Preconditions

* Assertions and preconditions are checks that happen at runtime.
* Assertions help you find mistakes and incorrect assumptions during development, and preconditions help you detect issues in production.
* Assertions and preconditions aren’t used for recoverable or expected errors. Because a failed assertion or precondition indicates an invalid program state, there’s no way to catch a failed assertion.
* Stopping execution as soon as an invalid state is detected also helps limit the damage caused by that invalid state.
* The difference between assertions and preconditions is in when they’re checked: Assertions are checked only in debug builds, but preconditions are checked in both debug and production builds
* In production builds, the condition inside an assertion isn’t evaluated. This means you can use as many assertions as you want during your development process, without impacting performance in production.

https://www.youtube.com/watch?v=08c0e7CV5wY
