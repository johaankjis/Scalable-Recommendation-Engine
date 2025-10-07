"""
Configuration management for the recommendation engine.
"""

from pydantic_settings import BaseSettings
from functools import lru_cache

class Settings(BaseSettings):
    """Application settings loaded from environment variables."""
    
    # Database
    database_url: str = "postgresql://user:password@localhost:5432/recommendations"
    db_pool_min_size: int = 10
    db_pool_max_size: int = 20
    
    # Redis
    redis_url: str = "redis://localhost:6379"
    redis_ttl: int = 600  # 10 minutes
    cache_key_prefix: str = "user_rec"
    
    # API
    api_title: str = "Recommendation Engine API"
    api_version: str = "1.0.0"
    api_description: str = "Scalable recommendation engine with ML-powered personalization"
    
    # Model
    model_path: str = "models/recommender.joblib"
    top_n_recommendations: int = 10
    min_interactions_for_personalized: int = 3
    
    # Performance
    request_timeout: int = 5
    max_concurrent_requests: int = 1000
    
    class Config:
        env_file = ".env"
        case_sensitive = False

@lru_cache()
def get_settings() -> Settings:
    """Get cached settings instance."""
    return Settings()
