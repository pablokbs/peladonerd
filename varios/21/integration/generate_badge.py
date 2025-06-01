import json
import sys

def generate_badge(coverage_pct):
    color = "red"
    if coverage_pct >= 90:
        color = "brightgreen"
    elif coverage_pct >= 80:
        color = "green"
    elif coverage_pct >= 70:
        color = "yellow"
    elif coverage_pct >= 60:
        color = "orange"

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