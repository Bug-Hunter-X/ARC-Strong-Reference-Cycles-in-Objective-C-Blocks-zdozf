# Objective-C ARC Strong Reference Cycle Bug

This repository demonstrates a common and subtle bug in Objective-C related to Automatic Reference Counting (ARC) and strong reference cycles within blocks.  Understanding and avoiding these cycles is crucial for preventing memory leaks in your applications.

## The Problem

The `bug.m` file contains code that inadvertently creates a strong reference cycle between a `MyClass` instance and a block.  Because the block captures `self` (implicitly via `self.myString`) and `self` may retain the block, neither can be deallocated, resulting in a memory leak.

## The Solution

The `bugSolution.m` file offers a solution to this problem by using `__weak` to break the strong reference cycle. The `__weak` keyword prevents the block from retaining `self`, allowing proper deallocation.