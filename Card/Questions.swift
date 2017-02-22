//
//  Cards.swift
//  Card
//
//  Created by Estevan Hernandez on 12/28/16.
//  Copyright © 2016 Estevan Hernandez. All rights reserved.
//

import Foundation

let kQueue = "queue"
let kDone = "done"
let kQueueFilePath = "/questions/queue"
let kDoneFilePath = "/questions/done"


class Questions: NSCoding {
	var queue: [String] = []
	var done: [String] = []
	var delegate:QuestionsDelegate?
	init () {
		queue = Questions.questionList()
	}
	func encode(with aCoder: NSCoder) {
		aCoder.encode(queue, forKey: kQueue)
		aCoder.encode(done, forKey: kDone)
	}
	init(queue: [String], done: [String]) {
		self.queue = queue
		self.done = done
	}
	func archiveQuestions() {
		if NSKeyedArchiver.archiveRootObject(queue, toFile: kQueueFilePath) {
			print("archive queue success")
		} else {
			print("archive queue fail")
		}
		if NSKeyedArchiver.archiveRootObject(done, toFile: kDoneFilePath) {
			print("archive done success")
		} else {
			print("archive done fail")
		}
		if let delegate = self.delegate {
			delegate.questionsArchived()
		} else {
			print("no delegate!")
		}
	}
	
	func unarchiveQuestions() {
		// MARK: Crash!!
		if let unarchivedQueue = NSKeyedUnarchiver.unarchiveObject(withFile: kQueueFilePath) as? [String] {
			queue = unarchivedQueue
		} else {
			print("unarchivedQueue nil")
		}
		
		if let unarchivedDone = NSKeyedUnarchiver.unarchiveObject(withFile: kDoneFilePath) as? [String] {
			done = unarchivedDone
		} else {
			print("unarchivedDone nil")
		}
		
		if let delegate = self.delegate {
			delegate.questionsUnarchived(questions: self)
		} else {
			print("no delegate!")
		}
		
	}
	required convenience init?(coder aDecoder: NSCoder) {
		guard
			let queue = aDecoder.decodeObject(forKey: kQueue) as? [String],
			let done = aDecoder.decodeObject(forKey: kDone) as? [String]
			else { return nil }
		
		self.init(queue: queue,
		          done: done)
	}
	class func questionList()->[String] {
		return [
			"What do you imagine an average night at our place would be?",
			"What do you most admire about me?",
			"What is a secret that you have been too afraid to tell me?",
			"What is our biggest challenge as a couple?",
			"What do you think I'm learning from you?",
			"If you could change one thing about my past, what would it be, and why?",
			"Do you believe that jealousy can be a component of a healthy marriage? Why or why not?",
			"A: What is a fear or insecurity you have abour our future?\nB: What do you plan to do to address that fear?",
			"When are you worried about me, and why?",
			"What's something you really want to know about me?",
			"What are some things you look forward to in our future together?",
			"What is a disagreement that you think might come up later that has not come up yet?",
			"What do you love about yourself?",
			"What are your top 3 memories of us together?",
			"When you think about the next 5 years, what are 3 things that come to mind?",
			"What do you think has equipped / shaped each of us to be a partner in this relationship?",
			"What is similar about us? What is different about us?",
			"When was the first time you really felt in love?",
			"Can you tell when I don't agree with you? (even if I don't say it)",
			"What are some things we could learn or imitate from our friends relationships?",
			"How would you describe me to others?",
			"What kind of future do you want to have? In reality, what kind of future do you think you'll have?",
			"When have you felt the closest to me?",
			"How has your love changed for me?",
			"Are you scared that I'll hurt you emotionall? How & Why?",
			"What do you love about me?",
			"What is the biggest sacrifice you've made that I haven't acknowledged?",
			"What is something new you've learned abour yourself recently?",
			"Tell me about when we first met",
			"Do you consider yourself good with money?",
			"What in our relationship are you most grateful for?",
			"Do you think/feel that I let you be \"you\" enough? Do you feel you have space to be you?",
			"What positive trait of mine would I do well to exercise more?",
			"Do you worry about my expectations of you?",
			"If you had to send me away for a month, where would you choose? Why?",
			"Which of the following do you want to work on most:\n•Love\n•Joy\n•Peace\n•Patience\n•Kindness\n•Goodness\n•Faith\n•Mildness\n•Self Control\n\nHow?",
			"Who sacrifices more in our relationship and how do you feel about that?",
			"When was the last time I made you feel secure as a man / woman?",
			"What do I smell like? Do you like it?",
			"What make you ♡loveable♡?",
			"What's your favorite imperfect thing about me?",
			"Tell me about a time you needed me and I was there.",
			"What do you think hinders me the most?",
			"What scares you about me?",
			"What scares you the most right now?",
			"What quality do you feel I could work on?",
			"How do you expect me to support you in the future?",
			"What scares you the most about being a husband / wife?",
			"What do I do that annoys you?",
			"How do you see us improving in the future?",
			"What is a pain in me you'd like to heal?",
			"What do you want to imitate from your parents relationship?",
			"How do you think is a good way we can communicate to eachother that we need space? (or time alone)",
			"What is one thing I still don't understand about you?",
			"What do you hold back from saying?",
			"What do you think I want from life?",
			"What's the most fun you've had with me and why?",
			"What kind of family do you want to have with me?",
			"What do you think will be some adjustments for me when we get married?",
			"What do you think is a weakness of mine in this relationship?",
			"♢ Have you ever had to forgive your mate for something big?",
			"♢ At the lowest point in your relationship, how did you build it back up?",
			"♢ What is a conversation you wish you had when you were dating?",
			"Do you think we're still a good match? Why or why not?",
			"Do you feel like we've lived up to the dreams we had when we started this relationship?",
			"What can each of us do to let the other one know they're not comfortable with the level of affection shown at the moment?",
			"Where do you see yourself in 5 years?",
			"What would make you leave me?",
			"Is there anything you feel would need to change before we got married?",
			"What do you want to remember when we go through tough rough times?",
			"What are you scared / hesitant to tell me?",
			"What do you think about reassessing our physical boundaries?",
			"What is something you are hoping to improve on in this relationship?",
			"What do you think you'd find out if you went through my phone right now?",
			"What does being best friends mean to you?",
			"What would you like to change about yourself?",
			"What do you love about my dad?",
			"What are your spiritual goals and why?",
			"What do you want me to do more?",
			"How have we grown lazy in our relationship?",
			"What does \"living simply\" mean to you?",
			"What's the most ridiculous thing I've done?",
			"Name the top 5 things you love about me",
			"What have I said that surprised you?",
			"What do you think (and how do you feel) about having kids?",
			"Describe a happy future memory",
			"Describe one experience you wish we'd have in the future",
			"If you ever feel your love for me waning, what would you do?",
			"When was the last time I surprised you and why?",
			"What is something you prefer your way over mine?",
			"Tell me a few of your \"#CoupleGoals\" for us",
			"Do you have expectations or fears about sex? If so, what?",
			"In what ways can I better support you personally and with your goals?",
			"What are a few standout moments that made you view me differently?",
			"What should I do if you start to self destruct?",
			"Do you think we'll still be this close in 15 years? Why or why not?",
			"When you close your eyes and think of me, what do you see?",
			"How can I be a better listener to you?",
			"What are you really insecure about?",
			"What do you want me to do less?",
			"How do you feel about opposite sex friends within a committed relationship?",
			"Tell me about a time I pleasantly surprised you? What about a time I disappointed you?",
			"What do you see in me that I don't see in myself?",
			"Why are you making this work right now?",
			"When do you feel most sexy?",
			"Do you remember the time you felt most attracted to me?",
			"Are there any embarassing medical conditions you have that I don't know about?",
			"What do you love about my mom?",
			"Tell me about a time when I did something that made you have a million questions?",
			"♢ What's the single most important thing to make it work? What have you done?",
			"♢ How far off were your expectations from reality?",
			"♢ Going back, would you date differently?",
			"♢ (For people who did not marry the first person they dated)\nWhat was different about your spouse that made it work?",
			"♢ Is there anything you've been meaning to do for your spouse that you haven't yet?",
			"♢ Do you feel like you can tell your spouse everything?",
			"♢ Is it a good idea to have complete honesty?",
			"♢ Are there things about your life from before your mate that you haven't told them yet?",
			"♢ What do you think is the subtlest form of erosion to a relationship?",
			"♢ What is the most corrosive to a relationship?",
			"♢ What is the biggest apsect of your personality that you consciously work on every day for your relationship?",
			"What's the wisest thing I've helped you learn?",
			"Which parts of traditional gender roles do you most want to deviate from? Which parts are you ok with?",
			"What are you most ashamed of?",
			"Have you ever needed a break from me? (Not like long term, I mean more like cabin fever, a breather) Did you take it? Why or why not?",
			"What do you want our place to look like? (Interior design)",
			"Tell me about something that makes you happy?",
			"What do you think you'd be \"strict\" about as a parent?",
			"What is preventing me from becoming the person I want to be?",
			"What is something you've been trying to find the words to say?",
			"Do you trust my ability to pass on the values that are important to you, to your children?",
			"What do you consider the greatest threat to your personal stability?",
			"What is one thing that I do that goes against something you believe in?",
			"What are you wearing right now?",
			"What's a memory from your childhood you most want to remember?",
			"What does \"our place\" or \"somewhere only we know\" mean to you? Where is it?",
			"What's a moment you will never forget about our time together?",
			"How has my behaviour changes since we got engaged?",
			"Do you ever picture us fighting?",
			"What is one thing you still haven't quite gotten used to about me?",
			"What do you think I'm missing out on by being with you?",
			"How often do you think about our wedding night?",
			"A: Is there a question you would never answer?\nB: Never ask?",
			"Have you felt jealous with me?",
			"What is one thing you wouldn't want your family to know?",
			"What are a few of your long-term goals?",
			"What single event from your childhood has most shaped the person you are now?",
			"What is one thing you're glad that I told you about?",
			"What do you wish you could give, that you just can't?",
			"What do you want to imitate about my parents relationship?",
			"Where do you want us to live?",
			"Would you want me to jump in front of traffic to save a child?"
		]
	}
}

protocol QuestionsDelegate {
	func questionsArchived()
	func questionsUnarchived(questions: Questions)
}
