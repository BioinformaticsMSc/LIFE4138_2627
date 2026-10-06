#!/usr/bin/env bash
set -euo pipefail

root=$(cd -- "$(dirname -- "$0")" && pwd)
reference="$root/reference/HVol_Complete.fasta"
inputs_only=false
if [[ ${1:-} == "--inputs-only" ]]; then
    inputs_only=true
elif [[ $# -gt 0 ]]; then
    printf 'Usage: %s [--inputs-only]\n' "$0" >&2
    exit 2
fi

[[ -s "$reference" ]] || { printf 'Missing reference: %s\n' "$reference" >&2; exit 1; }
shopt -s nullglob
reads=("$root"/barcode09/*.fastq.gz)
[[ ${#reads[@]} -gt 0 ]] || { printf 'No compressed FASTQ files found.\n' >&2; exit 1; }

gzip -t "${reads[@]}"
reference_stats=$(awk '{sub(/\r$/, "")} /^>/{records++; next} {bases += length($0)} END{printf "%d %d", records, bases}' "$reference")
read_stats=$(gzip -cd "${reads[@]}" | awk 'NR % 4 == 2 {reads++; bases += length($0)} END{printf "%d %d", reads, bases}')
printf 'reference_records reference_bases: %s\n' "$reference_stats"
printf 'read_records read_bases: %s\n' "$read_stats"
printf 'fastq_files: %d\n' "${#reads[@]}"

if [[ "$inputs_only" == false ]]; then
    for tool in minimap2 samtools; do
        command -v "$tool" >/dev/null || { printf 'Missing tool: %s\n' "$tool" >&2; exit 1; }
    done
    printf 'minimap2: %s\n' "$(minimap2 --version)"
    printf 'samtools: %s\n' "$(samtools --version | head -n 1)"
fi

printf 'Preflight passed.\n'
