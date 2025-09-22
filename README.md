```markdown
# Log Inspector 🔍

A powerful bash-based log analysis and real-time monitoring tool for system administrators and DevOps engineers.

## Features

- **📊 Time Distribution Analysis** - Group errors by time intervals
- **🔢 Counting & Statistics** - Quick count of specific events
- **📄 Full Text Search** - Find all occurrences with context
- **👀 Real-time Monitoring** - Live log tracking with multiple modes
- **🎯 Unique Pattern Detection** - Identify distinct error types

## Installation

```bash
git clone <your-repo-url>
cd log-inspector
chmod +x log_inspector.sh
```

## Quick Start

```bash
# Analyze error distribution over time
./log_inspector.sh time ERROR

# Count specific events (case-insensitive)
./log_inspector.sh count -i warning

# Monitor logs in real-time
./log_inspector.sh check target ERROR
```

## Usage Examples

### Basic Analysis
```bash
# Show when errors occur most frequently
./log_inspector.sh time ERROR

# Count total authentication failures
./log_inspector.sh count "authentication failed"

# Display all database connection issues
./log_inspector.sh all -i "database"
```

### Advanced Monitoring
```bash
# Monitor specific errors in real-time
./log_inspector.sh check target ERROR

# Analyze unique error patterns
./log_inspector.sh check uniq "failed"

# Watch entire log file live
./log_inspector.sh check
```

### Help & Documentation
```bash
# Display full help
./log_inspector.sh --help
```

## Modes Overview

### `time` Mode
Analyzes temporal distribution of events. Shows when specific patterns occur most frequently.

**Output Example:**
```
10:05 | 15 ERROR events
10:06 | 23 ERROR events
10:07 | 8 ERROR events
```

### `count` Mode  
Quick counting of pattern occurrences with case-insensitive option.

### `all` Mode
Displays all matching lines with full context and timestamps.

### `check` Mode - Real-time Monitoring

#### `check target <pattern>`
Monitors log file in real-time, filtering for specific patterns.

#### `check uniq <pattern>`
Shows unique error types and their frequency counts.

#### `check` (no arguments)
Monitors entire log file for complete system visibility.

## Options

- `-i` - Case-insensitive search (applies to time, count, all modes)
- `--help` - Display comprehensive help message

## Log Format Support

Currently supports timestamps in format: `[YYYY-MM-DD HH:MM:SS]`

Example log format:
```
[2023-10-25 14:30:01] ERROR Database connection failed
[2023-10-25 14:30:05] INFO User login successful
```

## Use Cases

### 🚨 Incident Response
```bash
# Quickly identify error spikes during outages
./log_inspector.sh time ERROR
```

### 🔍 Debugging
```bash  
# Track specific issue in real-time
./log_inspector.sh check target "NullPointerException"
```

### 📈 Trend Analysis
```bash
# Identify recurring unique errors
./log_inspector.sh check uniq "timeout"
```

### 👁️ System Monitoring
```bash
# General system health monitoring
./log_inspector.sh check
```

## Project Structure

```
log-inspector/ src /
├── log_inspector.sh    # Main script
├── example.log         # Sample log file
└── README.md          # This file
```
