"""
Update item popularity scores based on interaction data.
This script calculates popularity as a weighted sum of interactions.
"""

import os
import asyncpg
import asyncio

# Interaction type weights
INTERACTION_WEIGHTS = {
    'view': 1.0,
    'click': 2.0,
    'like': 2.5,
    'purchase': 3.0
}

async def update_popularity_scores():
    """Calculate and update popularity scores for all items."""
    
    # Get database URL from environment or use default
    database_url = os.getenv('DATABASE_URL', 'postgresql://user:password@localhost:5432/recommendations')
    
    # Connect to database
    conn = await asyncpg.connect(database_url)
    
    try:
        # Calculate popularity scores
        query = """
        WITH interaction_scores AS (
            SELECT 
                item_id,
                SUM(interaction_value) as total_score,
                COUNT(*) as interaction_count
            FROM interactions
            GROUP BY item_id
        )
        UPDATE items
        SET popularity_score = LEAST(
            (COALESCE(interaction_scores.total_score, 0) / 100.0), 
            1.0
        )
        FROM interaction_scores
        WHERE items.item_id = interaction_scores.item_id;
        """
        
        result = await conn.execute(query)
        print(f"[v0] Updated popularity scores: {result}")
        
        # Show top items by popularity
        top_items = await conn.fetch("""
            SELECT item_code, name, popularity_score 
            FROM items 
            ORDER BY popularity_score DESC 
            LIMIT 10
        """)
        
        print("\n[v0] Top items by popularity:")
        for item in top_items:
            print(f"  {item['item_code']}: {item['name']} (score: {item['popularity_score']:.3f})")
            
    finally:
        await conn.close()

if __name__ == "__main__":
    asyncio.run(update_popularity_scores())
