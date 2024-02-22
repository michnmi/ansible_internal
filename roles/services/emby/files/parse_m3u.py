#!/usr/bin/env python3
import argparse
import re

def extract_info(m3u8_file, channel_names=None, output_format='url', group_title=None):
    results = []
    with open(m3u8_file, 'r', encoding='utf-8') as file:
        lines = file.readlines()

    for i, line in enumerate(lines):
        if line.startswith('#EXTINF:-1'):
            match_group_title = re.search(r'group-title="([^"]*)"', line)
            current_group_title = match_group_title.group(1) if match_group_title else ""

            if group_title and group_title != current_group_title:
                continue  # Skip this channel since it doesn't match the group title

            if channel_names:
                match_tvg_name = re.search(r'tvg-name="([^"]*)"', line)
                current_tvg_name = match_tvg_name.group(1) if match_tvg_name else ""
                for name in channel_names:
                    if name == current_tvg_name:
                        url = lines[i + 1].strip()
                        if output_format == 'url':
                            results.append(url)
                        elif output_format == 'extinf':
                            results.append(f'{line.strip()}\n{url}')
                        elif output_format == 'name':
                            results.append(current_tvg_name)
                        break
            else:
                # If no specific channel names provided, add based on group-title only
                url = lines[i + 1].strip()
                if output_format == 'url':
                    results.append(url)
                elif output_format == 'extinf':
                    results.append(f'{line.strip()}\n{url}')
                elif output_format == 'name':
                    tvg_name = re.search(r'tvg-name="([^"]*)"', line).group(1) if re.search(r'tvg-name="([^"]*)"', line) else "Unknown"
                    results.append(tvg_name)

    return results

def read_channel_names(channel_names_file):
    if channel_names_file:
        with open(channel_names_file, 'r', encoding='utf-8') as file:
            return [line.strip() for line in file if line.strip()]
    return None

def write_results_to_file(results, output_file):
    with open(output_file, 'w', encoding='utf-8') as f:
        for result in results:
            f.write(f'{result}\n')

def parse_args():
    parser = argparse.ArgumentParser(description="Extract channel information from an m3u8 file.")
    parser.add_argument('--m3u8_file', required=True, help="Path to the m3u8 file")
    parser.add_argument('--channel_names_file', help="File containing channel names, one per line")
    parser.add_argument('--output_format', choices=['url', 'extinf', 'name'], default='url', help="Format of the output")
    parser.add_argument('--output_file', required=True, help="File to write the output")
    parser.add_argument('--group_title', help="Optional group title for filtering")
    return parser.parse_args()

def main():
    args = parse_args()

    channel_names = read_channel_names(args.channel_names_file) if args.channel_names_file else None
    results = extract_info(args.m3u8_file, channel_names, args.output_format, args.group_title)
    
    write_results_to_file(results, args.output_file)
    print(f"Extraction complete. Results written to {args.output_file}.")

if __name__ == "__main__":
    main()
