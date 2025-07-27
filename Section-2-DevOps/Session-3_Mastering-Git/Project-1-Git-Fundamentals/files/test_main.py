#!/usr/bin/env python3
"""
Test file for Git Fundamentals Project
Demonstrates testing practices in Git workflows
"""

import unittest
import sys
import os
from io import StringIO

# Add the parent directory to the path to import main
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from main import GitLearningApp

class TestGitLearningApp(unittest.TestCase):
    """Test cases for GitLearningApp"""
    
    def setUp(self):
        """Set up test fixtures"""
        self.app = GitLearningApp()
        
    def test_app_initialization(self):
        """Test app initialization"""
        self.assertEqual(self.app.version, "1.0.0")
        self.assertEqual(self.app.name, "Git Fundamentals Learning App")
        self.assertEqual(self.app.author, "DevOps Student")
        
    def test_welcome_message(self):
        """Test welcome message output"""
        # Capture stdout
        captured_output = StringIO()
        sys.stdout = captured_output
        
        self.app.welcome_message()
        
        # Reset stdout
        sys.stdout = sys.__stdout__
        
        output = captured_output.getvalue()
        self.assertIn("Welcome to Git Fundamentals Learning App", output)
        self.assertIn("Version: 1.0.0", output)
        
    def test_git_commands_demo(self):
        """Test git commands demonstration"""
        captured_output = StringIO()
        sys.stdout = captured_output
        
        self.app.git_commands_demo()
        
        sys.stdout = sys.__stdout__
        
        output = captured_output.getvalue()
        self.assertIn("Essential Git Commands", output)
        self.assertIn("git init", output)
        self.assertIn("git commit", output)
        
    def test_branching_strategy_info(self):
        """Test branching strategy information"""
        captured_output = StringIO()
        sys.stdout = captured_output
        
        self.app.branching_strategy_info()
        
        sys.stdout = sys.__stdout__
        
        output = captured_output.getvalue()
        self.assertIn("Git Branching Strategies", output)
        self.assertIn("GitFlow", output)
        self.assertIn("GitHub Flow", output)
        
    def test_collaboration_tips(self):
        """Test collaboration tips"""
        captured_output = StringIO()
        sys.stdout = captured_output
        
        self.app.collaboration_tips()
        
        sys.stdout = sys.__stdout__
        
        output = captured_output.getvalue()
        self.assertIn("Team Collaboration Tips", output)
        self.assertIn("commit messages", output)
        
    def test_run_method(self):
        """Test the main run method"""
        captured_output = StringIO()
        sys.stdout = captured_output
        
        self.app.run()
        
        sys.stdout = sys.__stdout__
        
        output = captured_output.getvalue()
        self.assertIn("Welcome to", output)
        self.assertIn("Essential Git Commands", output)
        self.assertIn("Git Branching Strategies", output)
        self.assertIn("Team Collaboration Tips", output)
        self.assertIn("Learning Complete", output)

class TestGitWorkflowSimulation(unittest.TestCase):
    """Test cases for simulating Git workflows"""
    
    def test_feature_branch_workflow(self):
        """Test feature branch workflow simulation"""
        # This would simulate a feature branch workflow
        workflow_steps = [
            "Create feature branch",
            "Make changes",
            "Commit changes",
            "Push to remote",
            "Create pull request",
            "Review and merge"
        ]
        
        self.assertEqual(len(workflow_steps), 6)
        self.assertIn("Create feature branch", workflow_steps)
        self.assertIn("Create pull request", workflow_steps)
        
    def test_merge_conflict_simulation(self):
        """Test merge conflict handling simulation"""
        conflict_resolution_steps = [
            "Identify conflicting files",
            "Open files in editor",
            "Resolve conflicts manually",
            "Stage resolved files",
            "Commit merge resolution"
        ]
        
        self.assertEqual(len(conflict_resolution_steps), 5)
        self.assertIn("Resolve conflicts manually", conflict_resolution_steps)
        
    def test_rebase_workflow(self):
        """Test rebase workflow simulation"""
        rebase_steps = [
            "Checkout feature branch",
            "Rebase onto main",
            "Resolve any conflicts",
            "Continue rebase",
            "Force push if needed"
        ]
        
        self.assertEqual(len(rebase_steps), 5)
        self.assertIn("Rebase onto main", rebase_steps)

if __name__ == "__main__":
    # Run the tests
    unittest.main(verbosity=2)
