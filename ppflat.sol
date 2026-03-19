// SPDX-License-Identifier: GPL
// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.18;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/IERC20Metadata.sol)

pragma solidity ^0.8.18;
/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 *
 * _Available since v4.1._
 */
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}

// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.18;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// OpenZeppelin Contracts (last updated v4.8.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.18;
/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * The default value of {decimals} is 18. To change this, you should override
 * this function so it returns a different value.
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC20
 * applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the default value returned by this function, unless
     * it's overridden.
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 9;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `amount`.
     */
    function transferFrom(address from, address to, uint256 amount) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    /**
     * @dev Moves `amount` of tokens from `from` to `to`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     */
    function _transfer(address from, address to, uint256 amount) internal virtual {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
            // Overflow not possible: the sum of all balances is capped by totalSupply, and the sum is preserved by
            // decrementing then incrementing.
            _balances[to] += amount;
        }

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        unchecked {
            // Overflow not possible: balance + amount is at most totalSupply + amount, which is checked above.
            _balances[account] += amount;
        }
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
            // Overflow not possible: amount <= accountBalance <= totalSupply.
            _totalSupply -= amount;
        }

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
     * e.g. set automatic allowances for certain subsystems, etc.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `owner` cannot be the zero address.
     * - `spender` cannot be the zero address.
     */
    function _approve(address owner, address spender, uint256 amount) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Updates `owner` s allowance for `spender` based on spent `amount`.
     *
     * Does not update the allowance amount in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Might emit an {Approval} event.
     */
    function _spendAllowance(address owner, address spender, uint256 amount) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual {}

    /**
     * @dev Hook that is called after any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * has been transferred to `to`.
     * - when `from` is zero, `amount` tokens have been minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens have been burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual {}
}

pragma solidity ^0.8.18;
contract PandaPoints is ERC20{
    //contract by Pantalipe
    //Never say no to PandaPoints •ﻌ•
    event TokenBuy(uint256 tA, uint256 nA);
    event TokenSell(uint256 tA, uint256 nA);

    address public pandaMasterOwner;

    address[2] public PanDirectorsWallets;

    struct Argss {
        address wal;
        uint8 sig;
        string sy;
        uint256 sl;
        uint256 cr;
        uint256 bs;
        uint256 ss;
    }

    Argss public signArgs; 

    mapping(address => mapping(string => uint256)) public sBalance;

    struct Stable {
        uint256 limitB;
        uint256 limitS;
        uint256 pB;
        uint256 pS;
    }
    
    mapping(string => Stable) public stables;
    mapping(address => uint256) public wlStable;

    struct StakeInfo {
    uint256 balance;
    uint256 reward;
    uint256 limit;
    }

    mapping(address => StakeInfo) public stakingInfo;

    uint256 public stakingTotalBalance = 0;

    mapping (address => address) public refLi;
    mapping (address => uint256) public refVa;

    mapping (address => uint8) public tFBl;

    uint256 public bnbLiquidity = 0;
    uint256 public tokenLiquidity = 0;
    uint256 public liquidityReward = 0;

    mapping (address => uint256) public liquidity;
    mapping (address => uint256) public liquidityWithdrawMinTime;

    constructor() ERC20("Panda Points", "PP") {

        pandaMasterOwner = msg.sender;
        
        _mint(address(this), 1_000_000_000000000); 

        PanDirectorsWallets[0] = 0x24063D1954cb39768F777FE33F53323C26f3a8b0; //dev
        PanDirectorsWallets[1] = 0x7a1756eaeAc2E3A744EDd0Ca85C8E7b23CD9Aa9A; //marketing/infra/inovation

        stables['PBRL'].pB = 1_000000000;
        stables['PBRL'].limitB = 20_000_000000000;

    }

    modifier onlyPandaMasterOwner(){
        require(msg.sender == pandaMasterOwner);
        _;
    }

    modifier onlyMultsignedOwner(){
        require(msg.sender == pandaMasterOwner && signArgs.sig == 2);
        _;
    }

    function signWallet() public{
        require(msg.sender == PanDirectorsWallets[signArgs.sig]);

        signArgs.sig += 1;
    }

    function changeWallets() public onlyMultsignedOwner{

        PanDirectorsWallets[signArgs.sl] = signArgs.wal;

        signArgs = Argss(0x0000000000000000000000000000000000000000, 0, "", 0, 0, 0, 0);
    }

    function changeOwner() public onlyMultsignedOwner{

        pandaMasterOwner = signArgs.wal;

        signArgs = Argss(0x0000000000000000000000000000000000000000, 0, "", 0, 0, 0, 0);

    }

    function setSignArgs(address _adarg, string calldata _sym, uint256 _iarg, uint256 _varg, uint256 _vargg, uint256 _varggg) public onlyPandaMasterOwner{

        signArgs = Argss(_adarg, 0, _sym, _iarg, _varg, _vargg, _varggg);
        
    }

    function setWl(address _ad, uint256 _in) public onlyPandaMasterOwner{
        wlStable[_ad] = _in;
    }

    function setTFBl(address _add, uint8 _inn) public onlyPandaMasterOwner{
        tFBl[_add] = _inn;
    }

    function regRef(address _adref) public{
        require(refLi[msg.sender] == 0x0000000000000000000000000000000000000000 && _adref != 0x0000000000000000000000000000000000000000);
        refLi[msg.sender] = _adref;
    }

    function withdrawRef() public{
        require(refVa[msg.sender] > 0);
        uint256 am = refVa[msg.sender];
        refVa[msg.sender] = 0;
        payable(msg.sender).transfer(am);
    }

    function addStable(string calldata _stin, address _addr, uint256 _val) public{
        require(msg.sender == pandaMasterOwner || (wlStable[msg.sender] >= _val && sBalance[msg.sender][_stin] >= _val));

        sBalance[_addr][_stin] += _val;

        if (msg.sender != pandaMasterOwner){
            sBalance[msg.sender][_stin] -= _val;
        }
    }

    function subStable(string calldata _stinn, address _addrr, uint256 _vall) public{
        require(msg.sender == pandaMasterOwner || wlStable[msg.sender] > 0);

        sBalance[_addrr][_stinn] -= _vall;

        sBalance[msg.sender][_stinn] += _vall;
    }
    
    function setStableRate() public onlyMultsignedOwner{

        stables[signArgs.sy] = Stable(signArgs.sl, signArgs.cr, signArgs.bs, signArgs.ss);

        signArgs = Argss(0x0000000000000000000000000000000000000000, 0, "", 0, 0, 0, 0);
        
    }

    function swapTokenForStable(string calldata _stain, uint8 _bsin, uint256 _amount) public{

            Stable memory sta = stables[_stain];

            if (_bsin == 0){
                require(sta.pB > 0 && sta.limitB > 0 && sBalance[msg.sender][_stain] > 0 && _amount > 0 && _amount <= sta.limitB);

                uint256 ttobuy = _amount * 1000000000 / sta.pB;

                require (ttobuy > 0 && balanceOf(address(this)) >= ttobuy && sBalance[msg.sender][_stain] >= _amount);

                if (refLi[msg.sender] != 0x0000000000000000000000000000000000000000){
                    super._transfer(address(this), msg.sender, (ttobuy - (ttobuy / 100)));
                    super._transfer(address(this), refLi[msg.sender], ttobuy / 100);
                }else{
                    super._transfer(address(this), msg.sender, ttobuy);
                }

                sBalance[msg.sender][_stain] -= _amount;

                stables[_stain].limitB -= _amount;

                tokenLiquidity -= ttobuy;

            }else{

                require(sta.pS > 0 && sta.limitS > 0 && _amount > 0 && _amount <= sta.limitS);

                uint256 tam = _amount * 1000000000 / sta.pS;

                require (tam > 0 && balanceOf(msg.sender) >= tam);

                if (refLi[msg.sender] != 0x0000000000000000000000000000000000000000){
                    super._transfer(msg.sender, address(this), tam);
                    super._transfer(address(this), refLi[msg.sender], tam/100);
                    tam = tam - (tam/100);
                }else{
                    super._transfer(msg.sender, address(this), tam);
                }

                sBalance[msg.sender][_stain] += _amount;

                stables[_stain].limitS -= _amount;

                tokenLiquidity += tam;
            }
    }

    function buyTokens(uint256 _minToA) public payable returns (uint256 tokenAmount) {
        require(msg.value > 0 && bnbLiquidity > 0 && tokenLiquidity > 0 && msg.value <= bnbLiquidity/100);

        uint256 amountToBuy = ( (msg.value - (msg.value*5/100)) * tokenLiquidity ) / ( (msg.value - (msg.value*5/100)) + bnbLiquidity );

        uint256 aMTBMF = amountToBuy - (amountToBuy/100);

        require(amountToBuy > 0 && tokenLiquidity >= amountToBuy && amountToBuy >= _minToA);

        refVa[PanDirectorsWallets[0]] += msg.value/100;
        refVa[PanDirectorsWallets[1]] += (msg.value*2)/100;

        liquidityReward += (msg.value / 100);

        stakingTotalBalance += (amountToBuy/100);

        if (refLi[msg.sender] != 0x0000000000000000000000000000000000000000){
            refVa[refLi[msg.sender]] += (msg.value / 100);
        }else{
            refVa[msg.sender] += (msg.value / 100);
        }

        bnbLiquidity += (msg.value - (msg.value * 5 / 100));

        tokenLiquidity -= amountToBuy;

        super._transfer(address(this), msg.sender, aMTBMF);

        emit TokenBuy(aMTBMF, msg.value);

        return aMTBMF;

    }

    function hugeBuyTokens(uint256 _minToA) public payable returns (uint256 tokenAmount) {
        require(msg.value > 0 && bnbLiquidity > 0 && tokenLiquidity > 0 && msg.value > bnbLiquidity/100);

        uint256 amountToBuy = ( (msg.value - (msg.value*5/100)) * tokenLiquidity ) / ( (msg.value - (msg.value*5/100)) + bnbLiquidity*10 );

        if (amountToBuy >= tokenLiquidity/10){
            amountToBuy = tokenLiquidity/100;
        }

        uint256 aMTBMF = amountToBuy - (amountToBuy/100);

        require(amountToBuy > 0 && tokenLiquidity >= amountToBuy && amountToBuy >= _minToA);

        refVa[PanDirectorsWallets[0]] += msg.value/100;
        refVa[PanDirectorsWallets[1]] += (msg.value*2)/100;

        liquidityReward += (msg.value / 100);

        stakingTotalBalance += (amountToBuy/100);

        if (refLi[msg.sender] != 0x0000000000000000000000000000000000000000){
            refVa[refLi[msg.sender]] += (msg.value / 100);
        }else{
            refVa[msg.sender] += (msg.value / 100);
        }

        bnbLiquidity += (msg.value - (msg.value * 5 / 100));

        tokenLiquidity -= amountToBuy;

        super._transfer(address(this), msg.sender, aMTBMF);

        emit TokenBuy(aMTBMF, msg.value);

        return aMTBMF;

    }

    function sellTokens(uint256 _tamount, uint256 _minNA) public returns (uint256 bnbAmount) {
        require(_tamount > 0 && balanceOf(msg.sender) >= _tamount);

        uint256 amountofBNB = (_tamount * bnbLiquidity) / (tokenLiquidity + _tamount);

        uint256 amountofBnbMinusFees = ((_tamount * bnbLiquidity) / (tokenLiquidity + _tamount)) - 
        ((5 * _tamount * bnbLiquidity) / (tokenLiquidity + _tamount) / 100);
        
        require(bnbLiquidity >= amountofBNB && amountofBNB >= _minNA);
        
        super._transfer(msg.sender, address(this), _tamount);

        liquidityReward += (amountofBNB / 100);

        stakingTotalBalance += (_tamount/100);

        refVa[PanDirectorsWallets[0]] += amountofBNB/100;
        refVa[PanDirectorsWallets[1]] += ( (_tamount * bnbLiquidity)*2 / (tokenLiquidity + _tamount) ) / 100;

        if (refLi[msg.sender] != 0x0000000000000000000000000000000000000000){
            refVa[refLi[msg.sender]] += (amountofBNB / 100);
        }else{
            refVa[msg.sender] += (amountofBNB / 100);
        }

        tokenLiquidity += (_tamount - (_tamount/100));

        bnbLiquidity -= amountofBNB;

        emit TokenSell(_tamount,amountofBnbMinusFees);

        payable(msg.sender).transfer(amountofBnbMinusFees);

        return amountofBnbMinusFees;

    }
    
    function openTrading() public payable{
        require(msg.sender == pandaMasterOwner && bnbLiquidity == 0 && tokenLiquidity == 0 && msg.value != 0);
        bnbLiquidity = msg.value;
        tokenLiquidity = 1_000_000_000000000;
    }

    function addLiquidity(uint256 _liqToBuy) public payable{
        require(msg.value > 0 && bnbLiquidity > 0 && _liqToBuy > 0 && tokenLiquidity > 0);
        uint256 lpRatio = tokenLiquidity * bnbLiquidity;
        uint256 bnbToAdd = _liqToBuy * bnbLiquidity / lpRatio;
        
        uint256 tokensToAdd = _liqToBuy * tokenLiquidity / lpRatio;
        
        require(tokensToAdd <= balanceOf(msg.sender) && tokensToAdd > 0 && bnbToAdd > 0 && bnbToAdd == msg.value);
        super._transfer(msg.sender, address(this), tokensToAdd);
        
        liquidity[msg.sender] += _liqToBuy;
        
        bnbLiquidity += msg.value;
        tokenLiquidity += tokensToAdd;
        liquidityWithdrawMinTime[msg.sender] = block.timestamp + 86400;  
    }

    function removeLiquidity(uint256 _liqToRemove) public{
        require(_liqToRemove > 0 && _liqToRemove < (tokenLiquidity * bnbLiquidity)/2 && liquidity[msg.sender] > 0 && liquidity[msg.sender] >= _liqToRemove && liquidityWithdrawMinTime[msg.sender] <= block.timestamp);
        uint256 lpRatio = tokenLiquidity * bnbLiquidity;
        uint256 bnbToRemove = _liqToRemove * bnbLiquidity / lpRatio;
        uint256 tokenToRemove = _liqToRemove * tokenLiquidity / lpRatio;
        uint256 liquidityRewardToRemove =  _liqToRemove * liquidityReward / lpRatio;
        
        require(bnbToRemove > 0 && tokenToRemove > 0);
        liquidity[msg.sender]-=_liqToRemove;
        bnbLiquidity-=bnbToRemove;
        tokenLiquidity-=tokenToRemove;
        liquidityReward-=liquidityRewardToRemove;
        liquidityWithdrawMinTime[msg.sender] = block.timestamp + 86400;
        super._transfer(address(this), msg.sender, tokenToRemove);
        payable(msg.sender).transfer(bnbToRemove + liquidityRewardToRemove);
    }

    function hugeUnbalancedEmergencialRemoveLiquidity(uint256 _liqToRemove) public{
        require(_liqToRemove >= (tokenLiquidity * bnbLiquidity)/2 && liquidity[msg.sender] > 0 && liquidity[msg.sender] >= _liqToRemove && liquidityWithdrawMinTime[msg.sender] <= block.timestamp);
        uint256 lpRatio = tokenLiquidity * bnbLiquidity;
        uint256 bnbToRemove = _liqToRemove * bnbLiquidity / lpRatio;
        uint256 tokenToRemove = _liqToRemove * tokenLiquidity / lpRatio;
        uint256 liquidityRewardToRemove =  _liqToRemove * liquidityReward / lpRatio;

        if (tokenToRemove >= tokenLiquidity/2){
            tokenToRemove = tokenLiquidity / 100;
        }
        if (bnbToRemove >= bnbLiquidity/2){
            bnbToRemove = bnbLiquidity / 100;
        }
        if (liquidityRewardToRemove >= liquidityReward){
            liquidityRewardToRemove = liquidityReward / 100;
        }
        
        liquidity[msg.sender]-=_liqToRemove;
        bnbLiquidity-=bnbToRemove;
        tokenLiquidity-=tokenToRemove;
        liquidityReward-=liquidityRewardToRemove;
        liquidityWithdrawMinTime[msg.sender] = block.timestamp + 86400;

        require(tokenToRemove > 0 || bnbToRemove+liquidityRewardToRemove > 0);
        if (tokenToRemove > 0){
            super._transfer(address(this), msg.sender, tokenToRemove);
        }
        if (bnbToRemove+liquidityRewardToRemove > 0){
            payable(msg.sender).transfer(bnbToRemove + liquidityRewardToRemove);
        }
    }

    function stakeTokens(uint256 _tAmount) public {
        require(_tAmount > 0 && stakingInfo[msg.sender].balance == 0 && balanceOf(msg.sender) >= _tAmount);
        super._transfer(msg.sender, address(this), _tAmount);
        uint256 stakeReward = _tAmount / 100;
        require(stakeReward <= stakingTotalBalance && stakeReward > 0);
        stakingInfo[msg.sender].balance = _tAmount;
        stakingInfo[msg.sender].reward = stakeReward;
        stakingInfo[msg.sender].limit = block.timestamp + 2592000;
        stakingTotalBalance -= stakeReward;
    }

    function withdrawStakeTokens() public {
        require(stakingInfo[msg.sender].balance > 0 && stakingInfo[msg.sender].limit < block.timestamp);
        super._transfer(address(this), msg.sender, (stakingInfo[msg.sender].balance + stakingInfo[msg.sender].reward));
        stakingInfo[msg.sender].balance = 0;
        stakingInfo[msg.sender].reward = 0;
        stakingInfo[msg.sender].limit = 0;
    }

    function addStakeTokens(uint256 _tAmount) public {
        require(_tAmount > 0 && stakingInfo[msg.sender].balance > 0 && stakingInfo[msg.sender].limit > block.timestamp && balanceOf(msg.sender) >= _tAmount);
        super._transfer(msg.sender, address(this), _tAmount);

        uint256 stakedReward = (stakingInfo[msg.sender].reward * ( block.timestamp - ( stakingInfo[msg.sender].limit - 2592000 ) )) / 2592000;

        uint256 stakeReward = (_tAmount + stakedReward + stakingInfo[msg.sender].balance) / 100;
        stakingTotalBalance += stakingInfo[msg.sender].reward;
        require(stakeReward+stakedReward <= stakingTotalBalance);

        stakingInfo[msg.sender].balance += (_tAmount + stakedReward);

        stakingInfo[msg.sender].reward = stakeReward;

        stakingInfo[msg.sender].limit = block.timestamp + 2592000;

        stakingTotalBalance -= (stakeReward+stakedReward);
        
    }

    receive() external payable{
        bnbLiquidity += msg.value - (msg.value * 4 / 100);
        refVa[PanDirectorsWallets[0]] += msg.value/100;
        refVa[PanDirectorsWallets[1]] += (msg.value*2)/100;
        liquidityReward += msg.value / 100;
    }
    
    function _transfer(address from, address to, uint256 amount) internal override {

        if (tFBl[from] == 0 && tFBl[to] == 0){
            super._transfer(from, to, amount);
       }else {
            uint256 feeam = amount * 4 / 100;

            super._transfer(from, address(this), feeam);

            super._transfer(from, PanDirectorsWallets[0], feeam / 4);
            super._transfer(from, PanDirectorsWallets[1], feeam / 2);
            stakingTotalBalance += (feeam / 4);

            super._transfer(from, to, amount - feeam);
        }

    }

}