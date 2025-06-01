import json
import sys
import os

def get_badge_color(coverage_pct):
    if coverage_pct >= 90:
        return "brightgreen"
    elif coverage_pct >= 80:
        return "green"
    elif coverage_pct >= 70:
        return "yellow"
    elif coverage_pct >= 60:
        return "orange"
    return "red"

def generate_badge(coverage_pct):
    color = get_badge_color(coverage_pct)
    
    # Set GitHub Actions environment variables
    with open(os.environ['GITHUB_ENV'], 'a') as f:
        f.write(f"COVERAGE={coverage_pct}%\n")
        f.write(f"COVERAGE_COLOR={color}\n")

    badge_json = {
        "schemaVersion": 1,
        "label": "coverage",
        "message": f"{coverage_pct}%",
        "color": color
    }

    return json.dumps(badge_json, indent=2)

def main():
    with open('coverage.json') as f:
        data = json.load(f)
        total = data['totals']['percent_covered_display']
        coverage_pct = float(total)
        
    badge_json = generate_badge(coverage_pct)
    
    with open('coverage-badge.json', 'w') as f:
        f.write(badge_json)

if __name__ == '__main__':
    main() 