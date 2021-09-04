function isPalindrome(p) {
  if (p === null || (typeof p !== 'string' && !(p instanceof String))) {
      return false;
  }
  if (p.length <= 1) {
    return true;
  }
  var n = p.toLowerCase().replace(/[^a-zA-Z]+/g, '');
  var len = n.length;
  // console.log('normalized = ' + n);
  
  for (var i=0; i < len/2; i++) {
    if (n.charAt(i) != n.charAt(len - i - 1)) {
      return false;
    }
  }
  return true;
}

function test(cond, message) {
  console.log(message + (cond ? ': pass' : ': fail'));
}

test(true, "truth");
test(isPalindrome(''), 'empty string');
test(isPalindrome('z'), 'one char');
test(!isPalindrome('za'), 'za');
test(isPalindrome('oozaKazoo'), 'oozaKazoo');
test(isPalindrome('A man, a plan, a canal. Panama!'), 'Panama');

