#!/usr/bin/env python3
"""
Configuration file for Git Fundamentals Project
Demonstrates configuration management in Git workflows
"""

import os
from typing import Dict, Any

class GitProjectConfig:
    """Configuration class for Git learning project"""
    
    def __init__(self):
        self.config = self._load_default_config()
        self._load_environment_config()
        
    def _load_default_config(self) -> Dict[str, Any]:
        """Load default configuration"""
        return {
            # Application settings
            "app": {
                "name": "Git Fundamentals Learning App",
                "version": "1.0.0",
                "debug": False,
                "log_level": "INFO"
            },
            
            # Git settings
            "git": {
                "default_branch": "main",
                "remote_name": "origin",
                "merge_strategy": "merge",
                "auto_push": False
            },
            
            # Development settings
            "development": {
                "auto_reload": True,
                "show_debug_info": True,
                "mock_external_services": True
            },
            
            # Testing settings
            "testing": {
                "test_database": ":memory:",
                "coverage_threshold": 80,
                "parallel_tests": True
            },
            
            # Collaboration settings
            "collaboration": {
                "require_code_review": True,
                "min_reviewers": 1,
                "auto_merge_enabled": False,
                "branch_protection": True
            },
            
            # CI/CD settings
            "cicd": {
                "auto_deploy_staging": True,
                "auto_deploy_production": False,
                "run_tests_on_pr": True,
                "security_scan_enabled": True
            }
        }
        
    def _load_environment_config(self):
        """Load configuration from environment variables"""
        # Override with environment variables if they exist
        if os.getenv("DEBUG"):
            self.config["app"]["debug"] = os.getenv("DEBUG").lower() == "true"
            
        if os.getenv("LOG_LEVEL"):
            self.config["app"]["log_level"] = os.getenv("LOG_LEVEL")
            
        if os.getenv("DEFAULT_BRANCH"):
            self.config["git"]["default_branch"] = os.getenv("DEFAULT_BRANCH")
            
        if os.getenv("AUTO_PUSH"):
            self.config["git"]["auto_push"] = os.getenv("AUTO_PUSH").lower() == "true"
            
    def get(self, key: str, default=None):
        """Get configuration value using dot notation"""
        keys = key.split(".")
        value = self.config
        
        try:
            for k in keys:
                value = value[k]
            return value
        except (KeyError, TypeError):
            return default
            
    def set(self, key: str, value: Any):
        """Set configuration value using dot notation"""
        keys = key.split(".")
        config = self.config
        
        for k in keys[:-1]:
            if k not in config:
                config[k] = {}
            config = config[k]
            
        config[keys[-1]] = value
        
    def get_git_config(self) -> Dict[str, Any]:
        """Get Git-specific configuration"""
        return self.config.get("git", {})
        
    def get_development_config(self) -> Dict[str, Any]:
        """Get development-specific configuration"""
        return self.config.get("development", {})
        
    def get_testing_config(self) -> Dict[str, Any]:
        """Get testing-specific configuration"""
        return self.config.get("testing", {})
        
    def get_collaboration_config(self) -> Dict[str, Any]:
        """Get collaboration-specific configuration"""
        return self.config.get("collaboration", {})
        
    def is_debug_mode(self) -> bool:
        """Check if debug mode is enabled"""
        return self.get("app.debug", False)
        
    def is_production_mode(self) -> bool:
        """Check if running in production mode"""
        return os.getenv("ENVIRONMENT", "development") == "production"
        
    def get_branch_strategy(self) -> str:
        """Get the configured branching strategy"""
        return self.get("git.merge_strategy", "merge")
        
    def should_require_review(self) -> bool:
        """Check if code review is required"""
        return self.get("collaboration.require_code_review", True)
        
    def get_min_reviewers(self) -> int:
        """Get minimum number of required reviewers"""
        return self.get("collaboration.min_reviewers", 1)
        
    def display_config(self):
        """Display current configuration"""
        print("🔧 Git Project Configuration:")
        print("=" * 40)
        
        for section, settings in self.config.items():
            print(f"\n[{section.upper()}]")
            for key, value in settings.items():
                print(f"  {key}: {value}")
                
    def export_config(self) -> Dict[str, Any]:
        """Export configuration as dictionary"""
        return self.config.copy()

# Global configuration instance
config = GitProjectConfig()

# Configuration presets for different environments
DEVELOPMENT_CONFIG = {
    "app.debug": True,
    "app.log_level": "DEBUG",
    "development.auto_reload": True,
    "development.show_debug_info": True
}

PRODUCTION_CONFIG = {
    "app.debug": False,
    "app.log_level": "WARNING",
    "development.auto_reload": False,
    "development.show_debug_info": False,
    "collaboration.require_code_review": True,
    "collaboration.min_reviewers": 2
}

TESTING_CONFIG = {
    "app.debug": True,
    "testing.parallel_tests": True,
    "testing.coverage_threshold": 90
}

def apply_preset(preset_name: str):
    """Apply a configuration preset"""
    presets = {
        "development": DEVELOPMENT_CONFIG,
        "production": PRODUCTION_CONFIG,
        "testing": TESTING_CONFIG
    }
    
    if preset_name not in presets:
        raise ValueError(f"Unknown preset: {preset_name}")
        
    preset = presets[preset_name]
    for key, value in preset.items():
        config.set(key, value)
        
    print(f"✅ Applied {preset_name} configuration preset")

if __name__ == "__main__":
    # Display current configuration
    config.display_config()
    
    print("\n" + "=" * 50)
    print("Configuration usage examples:")
    print(f"Debug mode: {config.is_debug_mode()}")
    print(f"Default branch: {config.get('git.default_branch')}")
    print(f"Require review: {config.should_require_review()}")
    print(f"Min reviewers: {config.get_min_reviewers()}")
