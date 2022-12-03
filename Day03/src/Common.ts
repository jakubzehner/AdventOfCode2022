function translateCharToPriority(char: string): number {
    const code = char.charCodeAt(0);
    return code > 90 ? code - 96 : code - 38;
}

export default translateCharToPriority;