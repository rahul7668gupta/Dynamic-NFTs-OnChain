// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console2} from "forge-std/Test.sol";
import {DeployMoodNft} from "../script/DeployMoodNft.s.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MoodNftTest is Test {
    MoodNft moodNft;

    string public SAD_NFT_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZE5mdCIsICJkZXNjcmlwdGlvbiI6IkFuIE5GVCB0aGF0IHJlZmxlY3RzIHRoZSBtb29kIG9mIHRoZSBvd25lciwgMTAwJSBvbiBDaGFpbiEiLCAiYXR0cmlidXRlcyI6IFt7InRyYWl0X3R5cGUiOiAibW9vZGluZXNzIiwgInZhbHVlIjogMTAwfV0sICJpbWFnZSI6ImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEQ5NGJXd2dkbVZ5YzJsdmJqMGlNUzR3SWlCemRHRnVaR0ZzYjI1bFBTSnVieUkvUGdvOGMzWm5JSGRwWkhSb1BTSXhNREkwY0hnaUlHaGxhV2RvZEQwaU1UQXlOSEI0SWlCMmFXVjNRbTk0UFNJd0lEQWdNVEF5TkNBeE1ESTBJaUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lQZ29nSUR4d1lYUm9JR1pwYkd3OUlpTXpNek1pSUdROUlrMDFNVElnTmpSRE1qWTBMallnTmpRZ05qUWdNalkwTGpZZ05qUWdOVEV5Y3pJd01DNDJJRFEwT0NBME5EZ2dORFE0SURRME9DMHlNREF1TmlBME5EZ3RORFE0VXpjMU9TNDBJRFkwSURVeE1pQTJOSHB0TUNBNE1qQmpMVEl3TlM0MElEQXRNemN5TFRFMk5pNDJMVE0zTWkwek56SnpNVFkyTGpZdE16Y3lJRE0zTWkwek56SWdNemN5SURFMk5pNDJJRE0zTWlBek56SXRNVFkyTGpZZ016Y3lMVE0zTWlBek56SjZJaTgrQ2lBZ1BIQmhkR2dnWm1sc2JEMGlJMFUyUlRaRk5pSWdaRDBpVFRVeE1pQXhOREJqTFRJd05TNDBJREF0TXpjeUlERTJOaTQyTFRNM01pQXpOekp6TVRZMkxqWWdNemN5SURNM01pQXpOeklnTXpjeUxURTJOaTQySURNM01pMHpOekl0TVRZMkxqWXRNemN5TFRNM01pMHpOeko2VFRJNE9DQTBNakZoTkRndU1ERWdORGd1TURFZ01DQXdJREVnT1RZZ01DQTBPQzR3TVNBME9DNHdNU0F3SURBZ01TMDVOaUF3ZW0wek56WWdNamN5YUMwME9DNHhZeTAwTGpJZ01DMDNMamd0TXk0eUxUZ3VNUzAzTGpSRE5qQTBJRFl6Tmk0eElEVTJNaTQxSURVNU55QTFNVElnTlRrM2N5MDVNaTR4SURNNUxqRXRPVFV1T0NBNE9DNDJZeTB1TXlBMExqSXRNeTQ1SURjdU5DMDRMakVnTnk0MFNETTJNR0U0SURnZ01DQXdJREV0T0MwNExqUmpOQzQwTFRnMExqTWdOelF1TlMweE5URXVOaUF4TmpBdE1UVXhMalp6TVRVMUxqWWdOamN1TXlBeE5qQWdNVFV4TGpaaE9DQTRJREFnTUNBeExUZ2dPQzQwZW0weU5DMHlNalJoTkRndU1ERWdORGd1TURFZ01DQXdJREVnTUMwNU5pQTBPQzR3TVNBME9DNHdNU0F3SURBZ01TQXdJRGsyZWlJdlBnb2dJRHh3WVhSb0lHWnBiR3c5SWlNek16TWlJR1E5SWsweU9EZ2dOREl4WVRRNElEUTRJREFnTVNBd0lEazJJREFnTkRnZ05EZ2dNQ0F4SURBdE9UWWdNSHB0TWpJMElERXhNbU10T0RVdU5TQXdMVEUxTlM0MklEWTNMak10TVRZd0lERTFNUzQyWVRnZ09DQXdJREFnTUNBNElEZ3VOR2cwT0M0eFl6UXVNaUF3SURjdU9DMHpMaklnT0M0eExUY3VOQ0F6TGpjdE5Ea3VOU0EwTlM0ekxUZzRMallnT1RVdU9DMDRPQzQyY3preUlETTVMakVnT1RVdU9DQTRPQzQyWXk0eklEUXVNaUF6TGprZ055NDBJRGd1TVNBM0xqUklOalkwWVRnZ09DQXdJREFnTUNBNExUZ3VORU0yTmpjdU5pQTJNREF1TXlBMU9UY3VOU0ExTXpNZ05URXlJRFV6TTNwdE1USTRMVEV4TW1FME9DQTBPQ0F3SURFZ01DQTVOaUF3SURRNElEUTRJREFnTVNBd0xUazJJREI2SWk4K0Nqd3ZjM1puUGdvPSJ9";
    string public HAPPY_NFT_URI =
        "data:application/json;base64,eyJuYW1lIjoiTW9vZE5mdCIsICJkZXNjcmlwdGlvbiI6IkFuIE5GVCB0aGF0IHJlZmxlY3RzIHRoZSBtb29kIG9mIHRoZSBvd25lciwgMTAwJSBvbiBDaGFpbiEiLCAiYXR0cmlidXRlcyI6IFt7InRyYWl0X3R5cGUiOiAibW9vZGluZXNzIiwgInZhbHVlIjogMTAwfV0sICJpbWFnZSI6ImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjJhV1YzUW05NFBTSXdJREFnTWpBd0lESXdNQ0lnZDJsa2RHZzlJalF3TUNJZ0lHaGxhV2RvZEQwaU5EQXdJaUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lQZ29nSUR4amFYSmpiR1VnWTNnOUlqRXdNQ0lnWTNrOUlqRXdNQ0lnWm1sc2JEMGllV1ZzYkc5M0lpQnlQU0kzT0NJZ2MzUnliMnRsUFNKaWJHRmpheUlnYzNSeWIydGxMWGRwWkhSb1BTSXpJaTgrQ2lBZ1BHY2dZMnhoYzNNOUltVjVaWE1pUGdvZ0lDQWdQR05wY21Oc1pTQmplRDBpTmpFaUlHTjVQU0k0TWlJZ2NqMGlNVElpTHo0S0lDQWdJRHhqYVhKamJHVWdZM2c5SWpFeU55SWdZM2s5SWpneUlpQnlQU0l4TWlJdlBnb2dJRHd2Wno0S0lDQThjR0YwYUNCa1BTSnRNVE0yTGpneElERXhOaTQxTTJNdU5qa2dNall1TVRjdE5qUXVNVEVnTkRJdE9ERXVOVEl0TGpjeklpQnpkSGxzWlQwaVptbHNiRHB1YjI1bE95QnpkSEp2YTJVNklHSnNZV05yT3lCemRISnZhMlV0ZDJsa2RHZzZJRE03SWk4K0Nqd3ZjM1puUGc9PSJ9";

    function setUp() external {
        DeployMoodNft moodNftDeployer = new DeployMoodNft();
        moodNft = moodNftDeployer.run();
    }

    function testTokenUriIsCorrect() external {
        moodNft.mintNft();
        string memory uri = moodNft.tokenURI(1);
        console2.log(uri);
    }

    function testFlipMoodToSad() external {
        moodNft.mintNft();
        moodNft.flipMood(1);
        string memory tokenIdUri = moodNft.tokenURI(1);
        assertEq(keccak256(bytes(tokenIdUri)), keccak256(bytes(SAD_NFT_URI)));
    }

    function testFlipMoodToSadToHappy() external {
        moodNft.mintNft();
        moodNft.flipMood(1); // flips to sad
        moodNft.flipMood(1); // flips to happy
        string memory tokenIdUri = moodNft.tokenURI(1);
        assertEq(keccak256(bytes(tokenIdUri)), keccak256(bytes(HAPPY_NFT_URI)));
    }
}
