#!/usr/bin/env python3
"""
Git Fundamentals Project - Main Application
A sample Python application for practicing Git operations
"""

import os
import sys
from datetime import datetime

class GitLearningApp:
    """Main application class for Git learning project"""
    
    def __init__(self):
        self.version = "1.0.0"
        self.name = "Git Fundamentals Learning App"
        self.author = "DevOps Student"
        
    def welcome_message(self):
        """Display welcome message"""
        print("=" * 50)
        print(f"Welcome to {self.name}")
        print(f"Version: {self.version}")
        print(f"Author: {self.author}")
        print(f"Current Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
        print("=" * 50)
        
    def git_commands_demo(self):
        """Demonstrate Git workflow concepts"""
        commands = [
            "git init - Initialize repository",
            "git add . - Stage all changes",
            "git commit -m 'message' - Commit changes",
            "git branch feature - Create new branch",
            "git checkout feature - Switch to branch",
            "git merge feature - Merge branch",
            "git push origin main - Push to remote"
        ]
        
        print("\n🔧 Essential Git Commands:")
        for i, cmd in enumerate(commands, 1):
            print(f"{i}. {cmd}")
            
    def branching_strategy_info(self):
        """Display branching strategy information"""
        strategies = {
            "GitFlow": "Feature branches, develop, main, hotfix, release",
            "GitHub Flow": "Feature branches directly to main",
            "GitLab Flow": "Environment branches with merge requests"
        }
        
        print("\n🌿 Git Branching Strategies:")
        for strategy, description in strategies.items():
            print(f"• {strategy}: {description}")
            
    def collaboration_tips(self):
        """Display collaboration best practices"""
        tips = [
            "Write clear, descriptive commit messages",
            "Keep commits small and focused",
            "Use branches for new features",
            "Review code before merging",
            "Pull latest changes before starting work",
            "Resolve conflicts promptly",
            "Use meaningful branch names"
        ]
        
        print("\n🤝 Team Collaboration Tips:")
        for i, tip in enumerate(tips, 1):
            print(f"{i}. {tip}")
            
    def run(self):
        """Main application runner"""
        self.welcome_message()
        self.git_commands_demo()
        self.branching_strategy_info()
        self.collaboration_tips()
        
        print("\n✅ Git Fundamentals Learning Complete!")
        print("Practice these concepts in your Git repository.")

def main():
    """Main function"""
    app = GitLearningApp()
    app.run()

if __name__ == "__main__":
    main()
